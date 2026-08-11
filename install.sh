#!/bin/bash
set -euo pipefail
os="$(uname -s)"
if [ "$os" = "Darwin" ]
then
    if ! xcode-select -p &>/dev/null
    then
        xcode-select --install 2>/dev/null || true
        echo "waiting for Xcode command line tools install - accept prompt that just appeared"
        until xcode-select -p &>/dev/null
        do
            sleep 10
        done
    fi
    if ! command -v brew &>/dev/null
    then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    if [ -x /opt/homebrew/bin/brew ]
    then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif
        [ -x /usr/local/bin/brew ]
    then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    brew install vim tmux mosh \
    starship \
    gh \
    pyenv ninja cmake \
    shellcheck \
    hyperfine btop flamegraph \
    ripgrep fd jq coreutils \
    cppcheck llvm \
    pandoc graphviz 
    brew install --cask mactex skim kicad bambu-studio || echo "cask install failed - check installs manually"
elif [ "$os" = "Linux" ] 
then
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y build-essential \
    zsh vim tmux mosh \
    git curl \
    ninja-build cmake \
    shellcheck gdb valgrind strace rr \
    hyperfine btop \
    ripgrep fd-find jq \
    cppcheck clang-tidy clang-format \
    pandoc \
    libssl-dev libffi-dev libreadline-dev zlib1g-dev \
    libbz2-dev libsqlite3-dev liblzma-dev libncurses-dev tk-dev
    mkdir -p "$HOME/.local/bin"
    if fdfind=$(command -v fdfind)
    then
    ln -sf "$fdfind" "$HOME/.local/bin/fd"
    fi
    sudo apt install -y linux-tools-generic "linux-tools-$(uname -r)" || sudo apt install -y linux-perf || echo "no perf matching this kernel - install manually"
    sudo mkdir -p -m 755 /etc/apt/keyrings
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null
    sudo apt update
    sudo apt install -y gh
    [ -d "$HOME/.pyenv" ] || curl -fsSL https://pyenv.run | bash
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
fi
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init - bash)"
python_version="$(pyenv latest -k 3.13)"
pyenv install -s "$python_version"
pyenv global "$python_version"
pip install numpy scipy matplotlib jupyter pandas sympy || echo "pip installs failed - install manually"
link_file() {
    local from="$1" to="$2"
    [ -f "$from" ] || { echo "$from missing from repository" >&2
    exit 1; }
    [ -e "$to" ] && [ ! -L "$to" ] && mv "$to" "$to.bak"
    rm -rf "$to"
    ln -s "$from" "$to" 
}
dotfiles_dir="$(cd "$(dirname "$0")" && pwd)"
for file in .vimrc .tmux.conf .zshrc .gitconfig
do
    link_file "$dotfiles_dir/$file" "$HOME/$file"
done
mkdir -p "$HOME/.config"
link_file "$dotfiles_dir/starship.toml" "$HOME/.config/starship.toml"
if [ "$os" = "Linux" ] && [ "$(basename "$SHELL")" != zsh ]
then
    sudo chsh -s "$(command -v zsh)" "$USER"
fi
read -rp "Set up GitHub (auth, sign, identity)? [y/N] " ans
if [[ "$ans" =~ ^[yY] ]]
then
    gh auth login -s admin:public_key,admin:ssh_signing_key --skip-ssh-key
    read -rp " name: " name
    read -rp " email: " email
    read -rp " ssh key path (reused if present, created if missing) [~/.ssh/id_ed25519]: " key
    key="${key:-$HOME/.ssh/id_ed25519}"
    key="${key/#\~/$HOME}"
    key="${key%.pub}"
    [ -f "$key" ] || ssh-keygen -t ed25519 -C "$email" -f "$key"
    ssh-keygen -lf "$key.pub" &>/dev/null || { echo "$key is not a usable ssh key" >&2
    exit 1; }
    gh ssh-key add "$key.pub" --type signing || echo "add signing key via gh manually"
    gh ssh-key add "$key.pub" --type authentication || echo "add auth key via gh manually"
    [ -f "$HOME/.gitconfig.local" ] && mv "$HOME/.gitconfig.local" "$HOME/.gitconfig.local.bak"
    cat > "$HOME/.gitconfig.local" << DONE
[user]
name = $name
email = $email
signingkey = $key.pub
[commit]
gpgsign = true
[gpg "ssh"]
allowedSignersFile = ~/.ssh/allowed_signers
DONE
    signer_line="$email $(cut -d' ' -f-2 "$key.pub")"
    grep -qxF "$signer_line" "$HOME/.ssh/allowed_signers" 2>/dev/null || echo "$signer_line" >> "$HOME/.ssh/allowed_signers"
fi

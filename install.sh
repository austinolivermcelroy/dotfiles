#!/bin/bash
set -euo pipefail

OS="$(uname -s)"

if [ "$OS" = "Darwin" ]; then
    if ! xcode-select -p &>/dev/null; then
        xcode-select --install 2>/dev/null || true
        echo "waiting for Xcode CLT install — accept the GUI prompt that just appeared"
        until xcode-select -p &>/dev/null; do
            sleep 10
        done
    fi

    if ! command -v brew &>/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi

    brew install vim tmux gh pyenv cmake starship coreutils \
        shellcheck pandoc mosh \
        hyperfine flamegraph btop \
        ripgrep fd jq \
        cppcheck llvm graphviz
    brew install --cask mactex kicad bambu-studio || echo "cask install failed — check installs manually"

elif [ "$OS" = "Linux" ]; then
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y build-essential vim tmux zsh gh cmake \
        shellcheck gdb valgrind strace rr \
        hyperfine btop pandoc mosh \
        linux-tools-common linux-tools-generic \
        ripgrep fd-find jq \
        cppcheck clang-tidy \
        libssl-dev libffi-dev libreadline-dev zlib1g-dev \
        libbz2-dev libsqlite3-dev liblzma-dev libncurses-dev tk-dev
    mkdir -p "$HOME/.local/bin"
    if FDFIND=$(command -v fdfind); then
        ln -sf "$FDFIND" "$HOME/.local/bin/fd"
    fi
    sudo apt install -y "linux-tools-$(uname -r)" || \
        echo "no linux-tools for kernel $(uname -r) — falling back to linux-tools-generic"
    curl -fsSL https://pyenv.run | bash
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

PYTHON_VERSION=$(pyenv install --list | grep -E '^\s+3\.[0-9]+\.[0-9]+$' | tr -d ' ' | sort -V | tail -1)
pyenv install -s "$PYTHON_VERSION"
pyenv global "$PYTHON_VERSION"

pyenv exec pip install numpy scipy matplotlib jupyter pandas sympy astropy poliastro scikit-learn cvxpy || echo "scientific stack install failed"
pyenv exec pip install pyansys || echo "pyansys install failed — check compatibility"

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
for file in .vimrc .tmux.conf .zshrc .gitconfig; do
    if [ -f "$DOTFILES_DIR/$file" ]; then
        rm -rf "$HOME/$file"
        ln -s "$DOTFILES_DIR/$file" "$HOME/$file"
    fi
done
if [ -f "$DOTFILES_DIR/starship.toml" ]; then
    mkdir -p "$HOME/.config"
    rm -rf "$HOME/.config/starship.toml"
    ln -s "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"
fi
if [ "$OS" = "Linux" ] && [ "$(basename "$SHELL")" != "zsh" ]; then
    chsh -s "$(command -v zsh)"
fi
read -rp "Set up gh CLI auth? [y/N] " ans
[[ "$ans" =~ ^[Yy]$ ]] && gh auth login
read -rp "Generate SSH key? [y/N] " ans
[[ "$ans" =~ ^[Yy]$ ]] && ssh-keygen -t ed25519

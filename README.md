### Linux 
```zsh
sudo apt update && sudo apt install -y git
cd ~
rm -rf ~/dotfiles
git clone https://github.com/austinolivermcelroy/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
cd ~
exec zsh
```

#### Debian - with root password preset
Run this alone first, log out, and then log back in to proceed with the above.
```zsh
su - -c "apt update && apt install -y sudo && usermod -aG sudo $USER"
```

### macOS
```zsh
cd ~
rm -rf ~/dotfiles
git clone https://github.com/austinolivermcelroy/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
cd ~
exec zsh
```

### Foundations
<pre>
Xcode Command Line Tools (macOS)
Homebrew (macOS)
build-essential (Linux)
</pre>

### Editors & Terminal
<pre>
vim
tmux
mosh
</pre>

### Shell
<pre>
zsh (Linux)
starship
</pre>

### Version Control
<pre>
gh
git
</pre>

### Languages & Environments
<pre>
pyenv
ninja
cmake
Python 
</pre>

### Debugging
<pre>
shellcheck
gdb (Linux)
valgrind (Linux)
strace (Linux)
rr (Linux)
</pre>

### Profiling
<pre>
hyperfine
btop
flamegraph (macOS)
perf (Linux)
</pre>

### Search & Data
<pre>
ripgrep
fd
jq
coreutils (macOS)
</pre>

### Linting
<pre>
cppcheck
llvm (macOS)
clang-tidy
clang-format
</pre>

### Fabrication
<pre>
KiCad (macOS)
Bambu Studio (macOS)
</pre>

### Scientific
<pre>
numpy
scipy
matplotlib
jupyter
pandas
sympy
</pre>

### LaTeX
<pre>
pandoc
graphviz (macOS)
MacTeX (macOS)
Skim (macOS)
</pre>

### Verified
<pre>
macOS 26.6.1
Ubuntu 26.04
Debian 13.6
</pre>

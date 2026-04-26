export PATH="$HOME/.local/bin:$PATH"
if [ -d "/opt/homebrew/opt/coreutils/libexec/gnubin" ]; then
    export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
elif [ -d "/usr/local/opt/coreutils/libexec/gnubin" ]; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi
export EDITOR=vim
export VISUAL=vim
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init - zsh)"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS

autoload -Uz compinit && compinit

bindkey -v
KEYTIMEOUT=1
bindkey '^R' history-incremental-search-backward
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

export LS_COLORS="di=38;5;67:ln=38;5;67:so=38;5;102:pi=38;5;102:ex=37:bd=38;5;59:cd=38;5;59:su=38;5;67:sg=38;5;67:tw=38;5;67:ow=38;5;67:fi=0:no=0:mi=38;5;59:or=38;5;59"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
alias ls='ls --color=auto'
export GREP_COLORS="mt=38;5;67:fn=0:ln=38;5;59:se=38;5;59"
alias grep='grep --color=auto'

export LESS_TERMCAP_mb=$'\e[38;5;67m'
export LESS_TERMCAP_md=$'\e[38;5;67m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[48;5;236;37m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[38;5;102m'

eval "$(starship init zsh)"

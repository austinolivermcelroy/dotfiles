export PATH="$HOME/.local/bin:$PATH"
if [ -x /opt/homebrew/bin/brew ]
then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]
then
    eval "$(/usr/local/bin/brew shellenv)"
fi
if [ -n "${HOMEBREW_PREFIX:-}" ] && [ -d "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" ]
then
    export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
fi

if [ -n "${HOMEBREW_PREFIX:-}" ] && [ -d "$HOMEBREW_PREFIX/opt/llvm/bin" ]
then 
    export PATH="$HOMEBREW_PREFIX/opt/llvm/bin:$PATH"
fi
export EDITOR=vim
export VISUAL=vim
export PATH="$HOME/.pyenv/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init - zsh)"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS
autoload -U compinit && compinit
bindkey -v
KEYTIMEOUT=1
bindkey '^?' backward-delete-char 
bindkey '^H' backward-delete-char
export LS_COLORS="di=38;5;67:ln=38;5;67:ex=37:bd=38;5;59:cd=38;5;59:mi=38;5;59:or=38;5;59"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
alias ls='ls --color=auto'
export GREP_COLORS="mt=38;5;67:ln=38;5;59:se=38;5;59:fn=0"
alias grep='grep --color=auto'
export LESS_TERMCAP_md=$'\e[38;5;67m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_us=$'\e[38;5;102m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_so=$'\e[48;5;236;37m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_mb=$'\e[38;5;67m'
command -v starship >/dev/null && eval "$(starship init zsh)"
link-class-macro() {
    local project_path="${1:?requires project path}"
    project_path="$(cd "$project_path" && pwd)" || return 1
    local texmf
    if [ "$(uname -s)" = "Darwin" ] 
    then
        texmf="$HOME/Library/texmf"
    else
        texmf="$HOME/texmf"
    fi
    local files=("$project_path"/*.cls(N) "$project_path"/*.sty(N))
    (( ${#files} )) || { echo "link-class-macro: neither .cls nor .sty in $project_path" >&2
    return 1; }
    local origin="$texmf/tex/latex/${project_path:t}"
    mkdir -p "$origin"
    local item
    for item in "${files[@]}"
    do
      ln -sf "$item" "$origin/${item:t}"
    done
    echo "link-class-macro: linked ${#files} file(s)"
}

    

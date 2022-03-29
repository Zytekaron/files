setopt autocd nomatch
unsetopt beep
bindkey -e
zstyle :compinstall filename '/home/z/.zshrc'

autoload -Uz compinit
compinit

autoload -U colors && colors
#PROMPT='%F{green}%n%F{red}@%F{green}%m:%F{blue}%~$ %F{reset}'
PROMPT='%F{blue}%~ %F{red}λ %F{reset}'

bindkey "^[[3~"   delete-char
bindkey "^H"      backward-kill-word
bindkey "^[[3;5~" kill-word
bindkey "^U"      backward-kill-line

# alt < | alt >
bindkey "^[f" forward-word
bindkey "^[b" backward-word

# ctrl < | ctrl >
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

eval $(thefuck --alias)

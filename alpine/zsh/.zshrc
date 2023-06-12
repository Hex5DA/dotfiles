HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

unsetopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/0x5da/.config/zsh/.zshrc'

autoload -Uz compinit
compinit

autoload -Uz promptinit
promptinit

setopt PROMPT_SUBST
PROMPT='%F{#7881C4}[%f%F{#FDC9B4}%1~%f%F{#7881C4}]%f %F{#7881C4}>%f '

# alias scrotsel=/usr/bin/scrot -F /home/0x5da/screenshots/capture:%G.%m.%d:%T.png -s -e 'xclip -selection clipboard -t image/png -i $f'
# "scrot -s -F /home/0x5da/screenshots/caputre:%G.%m.%d:%T.png -e 'xclip -selection clipboard -t image/png -i $f'"
alias scrotsel="/usr/bin/scrot -s -e 'xclip -selection clipboard -t image/png -i $f'"

# to force URXVT to place the PS1 at the top
# (& not vertically centered)
clear

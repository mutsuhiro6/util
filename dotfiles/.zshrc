export PROMPT="%~
%F{magenta}$ %f"

autoload -U compinit ; compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

export PATH="$PATH:/usr/local/bin"

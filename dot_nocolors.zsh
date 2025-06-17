# Minimalist, colorless shell environment (Acme-style)

# Disable color support
export TERM=kitty
export LS_COLORS=
export NO_COLOR=1

# Core utils
alias ls='ls --color=never'
alias grep='grep --color=never'
alias egrep='egrep --color=never'
alias fgrep='fgrep --color=never'
alias diff='diff --color=never'

# Git
export GIT_CONFIG_PARAMETERS="'color.ui=never'"
export GIT_PAGER="less -R"

# Pager and misc
export LESS=-R
alias bat='cat'
alias rg='rg --color=never'
alias top='TERM=dumb top'
alias htop='TERM=dumb htop'

# Optional prompt minimalism
autoload -Uz promptinit && promptinit
prompt off
unsetopt PROMPT_SP

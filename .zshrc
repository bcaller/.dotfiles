# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/ben/.oh-my-zsh
export EDITOR=vim
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="terminalparty"
#ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(command-not-found pip python vagrant vi-mode web-search wd colorize fasd)

#source $ZSH/oh-my-zsh.sh
# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g LL="2>&1 | less"

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

alias catc='colorize'
alias c='fasd_cd -d'

alias -g PI='3.14159265359'

source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle command-not-found
antigen bundle pip
antigen bundle python
antigen bundle vagrant
antigen bundle vi-mode
antigen bundle web-search
antigen bundle wd
antigen bundle colorize
antigen bundle fasd
antigen bundle tonyseek/oh-my-zsh-virtualenv-prompt
antigen bundle arzzen/calc.plugin.zsh
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle bcaller/zsh-navigation-tools
antigen theme bcaller/.zsh-theme theme
antigen apply

export TERM=rxvt-unicode

bindkey "^[[A" up-line-or-beginning-search
bindkey "\033[1~" beginning-of-line
bindkey "\033[4~" end-of-line

fortune | cowsay -pn

# ignore some files during completion
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
# but not for these programs
zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns

#znt
znt_list_border=1

source ~/.bash_aliases

function ranger-cd {
    tempfile="$(mktemp)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}
alias rcd="ranger-cd"
# choose a git hash with ipt and execute a command with {} replaced by the hash
alias h{}='git --no-pager lg -25 | ipt | cut -d " " -f 1 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | xargs -I {}'

autoload -U _crane
compdef _crane crn
compdef _crane crnd
setopt complete_aliases
fpath=(~/.zsh-functions $fpath)

# zshcontrib {{{1
## get infomation about version control systems {{{2
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%:%r'
precmd () { vcs_info }

## zle widgets {{{2
### predict-on {{{3
autoload -Uz predict-on
zle -N predict-on
zle -N predict-off
bindkey '^X^Z' predict-on
bindkey '^Z' predict-off
### }}}
## }}}
# }}}

# zshcompsys {{{1
autoload -Uz compinit
compinit
# }}}

# zshoptions {{{1
## changing directories {{{2
setopt auto_cd              # perform cd on directories
setopt auto_pushd           # make cd push the old directory onto the stack
setopt cd_silent            # never print working directory after cd
setopt chase_dots           # chase the .. path and remove it
setopt pushd_ignore_dups    # no duplicated directory
setopt pushd_minus          # exchange + and -
setopt pushd_silent         # never print the directory stack after pushd
setopt pushd_to_home        # pushd with no args act like `pushd $HOME`

## history {{{2
setopt hist_ignore_dups     # ignore duplicated entries in history
setopt hist_find_no_dups    # do not display duplicated entries
setopt hist_save_no_dups    # do not save duplicated entries

## input/output {{{2
setopt correct              # try to correct the commands
setopt print_exit_value     # print non-zero exit status

## prompting {{{2
# allow parameter expansion, command substitution and arithmetic expansion
# set this option to use `${vcs_info_msg_0_}` directly in the prompt
setopt prompt_subst

## scripts and functions {{{2
setopt multios              # perform tee or cat on multi-redirections

## shell emulation {{{2
setopt ksh_option_print     # print option status

## zle {{{2
setopt no_beep              # no error beep
## }}}
# }}}

# zshparam {{{1
## history {{{2
# where to save the history when an interactive shell exits
HISTFILE=$HOME/.histfile
# maximum number of events stored in the internal history list
HISTSIZE=9999
# maximum number of history events to save in the history file
SAVEHIST=9999
## prompt {{{2
_pr_date='%F{magenta}[%F{cyan}%D{%F %T %Z}%F{magenta}]%f'
_pr_tty='%F{magenta}[%F{green}%l%F{magenta}]%f'
_pr_user='%F{green}%n%f'
_pr_host='%B%F{blue}%M%f%b'
_pr_dir='%F{yellow}%~%f'
_pr_zsh='%fzsh%(2L./%L.)'
_pr_hist='%B%h%b'
_pr_priv='%(!.%B%F{red}#%f.%B%F{green}>%f%b)'
_pr_job='%(1j. [%F{yellow}%B%j%b%f].)'
# Display information of VCS if possible, using ${vcs_info_msg_0_}:
PS1='${_pr_date}${_pr_tty}
%F{magenta}<%f${_pr_user}@${_pr_host}:${_pr_dir}%F{magenta}>%f
${_pr_zsh} ${_pr_hist}${_pr_job} %U${vcs_info_msg_0_}%u${_pr_priv} '
# Show error status on last command if an error was occurred.
RPS1='%(?..%K{red}%B%F{white}E:(%?%)%f%b%k)'
PS2='%F{cyan}(%_)%f> %b%f%k'
## }}}
# }}}

# zshzle {{{1
# use emacs mode
bindkey -e
# fix the behavior of key `Delete`
bindkey "^[[3~" delete-char
# allow `Shift + Tab` to reverse traverse completion menu
bindkey "^[[Z" reverse-menu-complete
# }}}

# environment variable
export EDITOR=vim

# alias
alias grep="grep --color=auto"
alias ls="ls --color=auto"

# funtions {{{1
# a quick way to create .bak backup files, multiple files are supported
bak () {
    local desc='bak files => cp -v file1 file1.bak; cp -v file2 file2.bak;...'
    if [[ $# -eq 0 ]]; then
        print ${desc}
        return 1
    fi
    for i in $@; do
        if [[ -f $i ]]; then
            cp -v $i "$i.bak"
        else
            print "File not found: $i"
        fi
    done
}
# }}}

# activate zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# vim:fdm=marker

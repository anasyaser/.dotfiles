# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='\e[32m[\e[m\e[33m\W\e[32m]\e[m\e[m\e[0;31m>>\e[m '
#PS1='{_GREEN}[\W]>> '



# Edit paths for texlive configurations
export PATH="/usr/local/texlive/2023/bin/x86_64-linux:$PATH"
export MANPATH="/usr/local/texlive/2023/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2023/texmf-dist/doc/info:$INFOPATH"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/anoos/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/anoos/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/anoos/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/anoos/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$PATH:/home/anoos/pycharm/pycharm-2023.1/bin"
export PATH="$PATH:/home/anoos/clion/clion-2023.1/bin"


# customize aliases
alias pycharm='~/pycharm/pycharm-2023.1/bin/pycharm.sh'
alias intellij='~/idea-IU-231.9011.34/bin/idea.sh'
alias clion='~/clion/clion-2023.1/bin/clion.sh'
alias medge='microsoft-edge-stable'
alias slack='dbus-run-session flatpak run com.slack.Slack'
alias ivolume='amixer set Master 5dB+'
alias dvolume='amixer set Master 5dB-'

#java jkd
export JAVA_HOME="/usr/jdk/jdk-17"
export PATH="$JAVA_HOME/bin:$PATH"

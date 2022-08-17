export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:/usr/local/Cellar/git/2.37.1/bin"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
alias make='gmake'

autoload -Uz compinit
compinit
# Jupyter簡易起動
alias launch_jupyter='export DPORT=$(expr $RANDOM % 100 + 10000); echo "http://localhost:${DPORT}" | pbcopy; docker run --rm --memory=1024mb -v $(pwd):/app -p ${DPORT}:8888 -it hoto17296/anaconda3-ja jupyter notebook --notebook-dir=/app/ --ip=0.0.0.0 --port=8888 --allow-root --NotebookApp.token='''
alias launch_anaconda='export DPORT=$(expr $RANDOM % 100 + 10000); echo "http://localhost:${DPORT}" | pbcopy; docker run --rm --memory=1024mb -v $(pwd):/app -p ${DPORT}:8888 -it hoto17296/anaconda3-ja /bin/bash'

# psqlコマンド
alias psql="docker run --rm -it --net=host postgres:12 psql"
alias pg_dump='docker run --rm -it -v $(pwd):/tmp -w /tmp --net=host postgres:12 pg_dump'
alias pg_restore='docker run --rm -it -v $(pwd):/tmp -w /tmp --net=host postgres:12 pg_restore'

# git日本語文字化け修正コマンド
alias git_jp="git config --local core.quotepath false"

# git -> g
alias g="git"
# 補完を効かせる
compdef g=git

# git-promptの読み込み
source ~/.zsh/git-prompt.sh

# git-completionの読み込み
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
autoload -Uz compinit && compinit

# プロンプトのオプション表示設定
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

# プロンプトの表示設定(好きなようにカスタマイズ可)
setopt PROMPT_SUBST ; PS1='%F{green}%n@%m%f: %F{cyan}%~%f %F{red}$(__git_ps1 "(%s)")%f
\$ '

# local host ipアドレスを取得
export LOCAL_HOST_IP=`ifconfig en0 | grep inet | grep -v inet6 | sed -E "s/inet ([0-9]{1,3}.[0-9]{1,3}.[0-9].{1,3}.[0-9]{1,3}) .*$/\1/" | tr -d "\t"`

if [[ -x `which colordiff` ]]; then
  alias diff='colordiff'
fi

# prefix + [
bindkey '^[' peco-git-checkout
function peco-git-checkout () {
    local selected_branch=$(git branch --list --no-color | colrm 1 2 | peco)
    if [ -n "$selected_branch" ]; then
    BUFFER="git checkout ${selected_branch}"
    zle accept-line
    fi
    zle clear-screen
}
zle -N peco-git-checkout

# prefix + F
bindkey '^F' peco-src
function peco-src() {
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
    selected_dir="$GOPATH/ghq/$selected_dir"
    BUFFER="cd ${selected_dir}"
    zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src

# prefix + o
bindkey '^o' open-git-remote
function open-git-remote() {
    local selected=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$selected" ]; then
    if [ -x "`which wslview`" ]; then
        BUFFER="wslview https://${selected}"
    else
        BUFFER="open https://${selected}"
    fi
    zle accept-line
    fi
    zle clear-screen
}
zle -N open-git-remote

export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
export HISTSIZE=1000
export SAVEHIST=10000
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_all_dups

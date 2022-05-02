# Jupyter簡易起動
alias launch_jupyter='export DPORT=$(expr $RANDOM % 100 + 10000); echo "http://localhost:${DPORT}" | pbcopy; docker run --rm --memory=1024mb -v $(pwd):/app -p ${DPORT}:8888 -it hoto17296/anaconda3-ja jupyter notebook --notebook-dir=/app/ --ip=0.0.0.0 --port=8888 --allow-root --NotebookApp.token='''
alias launch_anaconda='export DPORT=$(expr $RANDOM % 100 + 10000); echo "http://localhost:${DPORT}" | pbcopy; docker run --rm --memory=1024mb -v $(pwd):/app -p ${DPORT}:8888 -it hoto17296/anaconda3-ja /bin/bash'

# psqlコマンド
alias psql="docker run --rm -it --net=host postgres:12 psql"

# git日本語文字化け修正コマンド
alias git_jp="git config --local core.quotepath false"

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

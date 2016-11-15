#!/bin/bash
set -e
DOT_DIRECTORY="${HOME}/dotfiles"
DOT_TARBALL="https://github.com/kentoohira/dotfiles/tarball/master"
REMOTE_URL="git@github.com:kentoohira/dotfiles.git"

has() {
  type "$1" > /dev/null 2>&1
}

# 使い方
usage() {
  name=`basename $0`
  cat <<EOF
Usage:
  $name [arguments] [command]
Commands:
  deploy
  initialize
Arguments:
  -f $(tput setaf 1)** warning **$(tput sgr0) Overwrite dotfiles.
  -h Print help (this message)
EOF
  exit 1
}

# オプション -fは上書き、-hはヘルプ表示
while getopts :f:h opt; do
  case ${opt} in
    f)
      OVERWRITE=true
      ;;
    h)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))


# Dotfilesがない、あるいは上書きオプションがあればダウンロード
if [ -n "${OVERWRITE}" -o ! -d ${DOT_DIRECTORY} ]; then
  echo "Downloading dotfiles..."
  rm -rf ${DOT_DIRECTORY}
  mkdir ${DOT_DIRECTORY}

  if type "git" > /dev/null 2>&1; then
    git clone --recursive "${REMOTE_URL}" "${DOT_DIRECTORY}"
  else
    curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOT_TARBALL}
    tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOT_DIRECTORY}
    rm -f ${HOME}/dotfiles.tar.gz
  fi

  echo $(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)
fi

link_files() {
  cd ${DOT_DIRECTORY}

  for f in .??*
  do
    # 無視したいファイルやディレクトリを追加
    [[ ${f} = ".git" ]] && continue
    [[ ${f} = ".gitignore" ]] && continue
    [[ ${f} = ".DS_Store" ]] && continue
    [[ ${f} = ".CFUserTextEncoding" ]] && continue
    [[ ${f} = ".Trash" ]] && continue
    [[ ${f} = ".gitconfig" ]] && continue
    [[ ${f} = ".ssh" ]] && continue
    [[ ${f} = ".vimimfo" ]] && continue
    [[ ${f} = ".zcompdump" ]] && continue
    [[ ${f} = ".zhistory" ]] && continue
    [[ ${f} = ".zplug" ]] && continue
    ln -snfv ${DOT_DIRECTORY}/${f} ${HOME}/${f}
  done
  echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
}

initialize() {
  if has "brew"; then
    echo "$(tput setaf 2)Already installed Homebrew ✔︎$(tput sgr0)"
  else
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  
  if has "brew"; then
    echo "Updating Homebrew..."
    brew update && brew upgrade
    [[ $? ]] && echo "$(tput setaf 2)Update Homebrew complete. ✔︎$(tput sgr0)"
  
    local list_formulae
    local -a missing_formulae
    local -a desired_formulae=(
      'git'
      'mysql'
      'the_silver_searcher'
      'zsh'
      'zplug'
      'nkf'
      'wget'
      'curl'
      'lua'
      'vim --with-lua'
    )
  
    local installed=`brew list`
  
    # desired_formulaeで指定していて、インストールされていないものだけ入れましょ
    for index in ${!desired_formulae[*]}
    do
      local formula=`echo ${desired_formulae[$index]} | cut -d' ' -f 1`
      if [[ -z `echo "${installed}" | grep "^${formula}$"` ]]; then
        missing_formulae=("${missing_formulae[@]}" "${desired_formulae[$index]}")
      else
        echo "Installed ${formula}"
        [[ "${formula}" = "ricty" ]] && local installed_ricty=true
      fi
    done
  
    if [[ "$missing_formulae" ]]; then
      list_formulae=$( printf "%s " "${missing_formulae[@]}" )
  
      echo "Installing missing Homebrew formulae..."
      brew install $list_formulae
  
      [[ $? ]] && echo "$(tput setaf 2)Installed missing formulae ✔︎$(tput sgr0)"
    fi
  
    # コマンド類の初期処理
    ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
  
    echo "Cleanup Homebrew..."
    brew cleanup
    echo "$(tput setaf 2)Cleanup Homebrew complete. ✔︎$(tput sgr0)"
  fi
  
  # シェルをzshにする
  [ ${SHELL} != "/bin/zsh"  ] && chsh -s /bin/zsh
  echo "$(tput setaf 2)Initialize complete!. ✔︎$(tput sgr0)"
}

# 引数によって場合分け
command=$1
[ $# -gt 0 ] && shift

# 引数がなければヘルプ
case $command in
  deploy)
    link_files
    ;;
  init*)
    initialize
    ;;
  *)
    usage
    ;;
esac

exit 0

#!/bin/bash
#> @desc
null=
##
echo "### 1st=$1 2nd=$2 3rd=$3 PWD=$(pwd) ###"
##
  if [[ $1 = "none" ]]; then
    holder="study-project"
  elif [[ $1 = 'cordova' ]]; then
    if [[ $2 = "$null" ]]; then
      echo "第２パラメタにフルパスを指定してください。"
      exit 1
    fi
    holder=$(cut -d '/' -f 4 <<< $2)
    if [[ ! -e ${holder} ]]; then
      echo "プロジェクトフォルダがありません。 : ${holder}"
      exit 1
    fi
    cd ${holder}
    cd hybrid
    module=$(cut -d '/' -f 6 <<< $2)
    if [[ ! -e ${module} ]]; then
      echo "ERROR モジュールフォルダがありません : ${module}"
      exit 1
    fi
    cd ${module}
    cd www
    lex cordova
    exit
  elif [[ $1 = 'electron' ]]; then
    if [[ $2 = "$null" ]]; then
      echo "第２パラメタにフルパスを指定してください。"
      exit 1
    fi
    holder=$(cut -d '/' -f 4 <<< $2)
    if [[ ! -e ${holder} ]]; then
      echo "プロジェクトフォルダがありません。 : ${holder}"
      exit 1
    fi
    cd ${holder}
    cd hybrid
    module=$(cut -d '/' -f 6 <<< $2)
    if [[ ! -e ${module} ]]; then
      echo "ERROR モジュールフォルダがありません : ${module}"
      exit 1
    fi
    cd ${module}
    cd www
    lex electron
    exit
  elif [[ $1 = 'packager' ]]; then
    if [[ $2 = "$null" ]]; then
      echo "第２パラメタにフルパスを指定してください。"
      exit 1
    fi
    holder=$(cut -d '/' -f 4 <<< $2)
    if [[ ! -e ${holder} ]]; then
      echo "プロジェクトフォルダがありません。 : ${holder}"
      exit 1
    fi
    cd ${holder}
    cd hybrid
    module=$(cut -d '/' -f 6 <<< $2)
    if [[ ! -e ${module} ]]; then
      echo "ERROR モジュールフォルダがありません : ${module}"
      exit 1
    fi
    cd ${module}
    cd www
    lex packager
    exit
  elif [[ $1 = 'file' ]]; then
    holder=$2
    if [[ ! -e ${holder} ]]; then
      echo "プロジェクトフォルダがありません。 : ${holder}"
      exit 1
    fi
    cd ${holder}
    cd hybrid
    module=$3
    if [[ ! -e ${module} ]]; then
      echo "ERROR モジュールフォルダがありません : ${module}"
      exit 1
    fi
    cd ${module}
    if [[ $4 = 'main.js' ]]; then
      cd www
      lex electron
    else
      lex cordova
    fi
    exit
  elif [[ -e $1 ]]; then
    holder=$1
  fi
  if [[ ! -e ${holder} ]]; then
    echo "ホルダがありません。: ${holder}"
    exit
  fi
  cd ${holder}
  if [[ ! -e hybrid ]]; then
    mkdir hybrid
  fi
  cd hybrid
  lex help
  /bin/bash
##

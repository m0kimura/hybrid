#!/bin/bash
#@module ubモードでの標準前処理
#@desc プロジェクトの取り出し、＄DIRの省略時設定
cmd=$1
project=${PWD##*/}
null=
if [[ $DIR = "$null" ]]; then
  DIR=$HOME
fi
echo "### project: ${project}, DIR: ${DIR}, cmd: ${cmd} ###"
##
#@module run-fx ドッカー管理コマンド対応
#@param 1st {String} dockerコマンド push/stop/login/export/save
#@require pp-*
  if [[ ${cmd} = "push" ]]; then
    dex push
    exit
  elif [[ ${cmd} = "start" ]]; then
    docker start fx-${project}
    exit
  elif [[ ${cmd} = "begin" ]]; then
    docker start -i fx-${project}
    exit
  elif [[ ${cmd} = "stop" ]]; then
    docker stop fx-${project}
    exit
  elif [[ ${cmd} = "login" ]]; then
    docker exec -it fx-${project} /bin/bash
    exit
  elif [[ ${cmd} = "export" ]]; then
    echo Export Container fx-${project} to local/fx-${project}.tar
    docker export fx-${project} -o ../local/fx-${project}.tar
    exit
  elif [[ ${cmd} = "save" ]]; then
    echo Save Image ${project} to local/${project}.tar
    docker save ${project} -o ../local/${project}.tar
    exit
  elif [[ ${cmd} = "volume" ]]; then
    name=fv-${project}
    volume=$2
    if [[ ${volume} = "$null" ]]; then
      volume=/home/docker
    fi
    docker run --name $name \
      -v ${volume} \
      busybox
    echo volume ${name} was made AS path ${volume}
    exit
  fi
##
#> @module run-temp-home 一時コンテナ、親HOMEを共有するdocker起動
#> @require pp-*
#> @desc 第３パラメータがnoitの時にバックグラウンドでの起動を意識しています。
##
it="-it"
##
  if [[ $2 = "noit" ]]; then
    it=""
  elif [[ $3 = "noit" ]]; then
    it=""
  elif [[ $4 = "noit" ]]; then
    it=""
  elif [[ $5 = "noit" ]]; then
    it=""
  fi
  echo "### it = ${it}, $3, $4, $5 ###"
  docker run ${it} -h ${project} --rm \
    -e DISPLAY=${DISPLAY} \
    -e XMODIFIERS="@im=fcitx" \
    -e XIM=fcitx \
    -e XIMPROGRAM=fcitx \
    -e GTK_IM_MODULE=$GTK_IM_MODULE \
    -e QT_IM_MODULE=$QT_IM_MODULE \
    -e LC_TYPE=ja_JP.UTF-8 \
    -e LANG=ja_JP.UTF-8 \
    -e TERM=xterm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME:/home/docker \
    -v /mnt:/mnt \
    m0kimura/${project} $1 $2 $3 $4 $5 $6 $7
##


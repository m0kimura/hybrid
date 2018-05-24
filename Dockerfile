FROM m0kimura/ubuntu-base

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND teletype

ARG user=${user:-docker}
RUN dpkg --add-architecture i386 \
&&  apt-get update -y \
&&  apt-get install -y --no-install-recommends apt-utils \
      software-properties-common \
&&  add-apt-repository -y ppa:ubuntu-wine/ppa \
&&  apt-get update -y \
&&  apt-get install -y \
      wine winetricks winbind \
      libgtk2.0-0 libx11-xcb-dev libxtst6 libxss1 libgconf-2-4 \
      libnss3-dev libasound2 libcanberra-gtk-module libappindicator1 \
&&  npm install electron -g --unsafe-perm=true \
&&  npm install -g asar \
&&  npm install -g electron-packager \
&&  usermod -aG video ${user}
##

#@module ux-java Java8関連のモジュールをインストールします。
#@desc 新UXシリーズ、１モジュール毎に完結します。
RUN echo "### ux-java8 ###" \
&&  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
&&  add-apt-repository -y ppa:webupd8team/java \
&&  apt-get update \
&&  apt-get install -y oracle-java8-installer gradle \
&&  rm -rf /var/cache/oracle-jdk8-installer
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
##

RUN echo "### ux-cordova ###" \
&&  apt-get install -y sudo ant lib32stdc++6 lib32z1 jq \
&&  npm install -g cordova \
&&  git clone https://github.com/m0kimura/cordova.git \
&&  cd /usr/local \
&&  wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz \
&&  tar zxvf android-sdk_r24.4.1-linux.tgz \
&&  export ANDROID_HOME=/usr/local/android-sdk-linux \
&&  export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools \
&&  echo y | android update sdk --no-ui --all --filter "android-26,build-tools-26.0.2" \
&&  echo y | android update sdk --no-ui --all --filter "platform-tool" \
&&  echo y | android update sdk --no-ui --all --filter "extra-google-m2repository,extra-android-m2repository" \
&&  rm -rf /usr/local/android-sdk_r24.4.1-linux.tgz
RUN apt-get update -y \
&&  apt-get install -y imagemagick
#@module ux-close インストール残骸を削除します。
#@desc ux-toolとペアで使用することを想定してます。
RUN echo "### ux-close ###" \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists/*
##
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
COPY ./parts/lex /usr/bin/lex
COPY ./parts/Helps /usr/bin/Helps
COPY ./parts/cordovaconf.jse /usr/bin/cordovaconf.jse
COPY ./parts/config.sh /usr/src/config.sh
COPY ./parts/master.cfg /usr/src/master.cfg
COPY ./parts/our-ide.json /usr/src/our-ide.json
COPY ./parts/exe /usr/src/exe
#@module ux-user 標準ユーザー環境による実行 です。
ENV HOME=/home/${user} USER=${user}
WORKDIR $HOME
USER $USER
RUN echo "### ux-user ###" \
&&  echo "export LANG=ja_JP.UTF-8" >> .bashrc
COPY ./starter.sh /usr/bin/starter.sh
ENTRYPOINT ["starter.sh"]
CMD ["none"]
##

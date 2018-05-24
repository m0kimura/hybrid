Hybridアプリ(CORDOVA,ELECTRON)開発環境
====

Hybridアプリとして、CORDOVA(スマートデバイス)、ELECTRON(パソコン）アプリの開発環境を提供します。　IDEとしてはATOMを想定しています。


## 説明
  - ユーザールートにあるプロジェクトフォルダを使って、アプリを開発します。
  - CORDOVA(iPhone、android)のビルドを行えます。
  - ELECTRON(windows,Mac,Linux)のビルドを行えます。
  - Dockerイメージはリポジトリからダウンロードされます。
  - 起動関係のシェル(linux)がdocker.shに準備されています。
  - コンテナは一時的なコンテナを使用します。


## 必要事項
  - Dockerがインストールされている必要があります。
  - atomインターフェイスを使用する場合は./docker.shで起動後、「lex setup」を実行してください。


## 使い方
クローンした後、次のコマンドを使用することができます。

### まずはためしてみる(Helpなども表示されます)
  <p>まずは試す場合には「study-project」ホルダを作成してから、次のコマンドを入れます。</p>
  ./docker.sh

### プロジェクトフォルダでcliモードにする
  ./docker.sh 「プロジェクトフォルダ」

### lexコマンドでの機能
  Helps lexで確認します。


## インストール
  git clone https://github.com/m0kimura/hybrid.git


## 構成
  - Dockerfile ドッカー構築ファイル
  - README.md 解説
  - docker.sh ドッカー起動、管理シェル
  - starter.sh 開始時実行ソース
  - parts/Helps ヘルプ用シェル
  - parts/lex ローカル実行シェル
  - parts/cordovaconf.jse コルドバ環境設定プログラム
  - parts/master.cfg コルドバアプリ設定マナー（全体的省略値）
  - parts/our-ide.json atomパッケージour-ide用設定ファイル
  - parts/exe atomパッケージインターフェイス起動マクロシェル

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)


## Author

[m0kimura](https://github.com/m0kimura)


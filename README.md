# README
dockerでRailsプロジェクトを開発環境を構築する

【動作環境】
- mac
- ruby:3.2.2
- rails:7.0.6
- postgres:12
  
## ①gitCloneをする
下記サイトを`$ git clone https://github.com/ihatov08/rails7_docker_template`でgit cloneをして取得する。

## ②プッシュするリポジトリを変更する。
`$ git remote set-url origin git@github.com:melons23/rails-docker.git`

`$ git remote -v`

origin	git@github.com:melons23/rails-docker.git (fetch)

origin	git@github.com:melons23/rails-docker.git (push)


## ③mainリポジトリをプッシュ

## ④dockerファイル編集用に`docker`ブランチを作成・ブランチ切り替え
`$ git checkout -b docker`

`$ git branch`でdockerがメインブランチになっていることが分かります。

## ⑤Dockerに必要なファイルを作成する
今回はGemfile,Gemfile.lockはすでにあるので、Dockerfileとcompose.yamlを作成します。

ディレクトリ移動をして、touchコマンドでファイルを作成して編集をします。

・ Dockerfile
  ```
FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
WORKDIR /myapp
COPY Gemfile Gemfile.lock /myapp/
RUN bundle install
ADD . /myapp
 ```

・ Gemfile

・ Gemfile.lock

・ compose.yaml
  composeのファイル名は書き方が複数ありますが、compose.yamlが推奨されています。
  
  参考) https://docs.docker.jp/compose/compose-file/index.html

  ```
  services:
    db:
      image: postgres:12
      volumes: 
        - .:/myapp
      environment:
        POSTGRES_USER: "postgres"
        POSTGRES_PASSWORD: "postgres5050"
    web:
      build: .
      command: bundle exec rails s -p 3000 -b '0.0.0.0'
      volumes:
        - .:/myapp
      ports:
        - "3000:3000"
      depends_on:
        - db
  ```

## ⑥buildしてイメージを作成する
`$ docker compose build `

イメージが無事作成できました。

`writing image sha256:7f6baa12d2730d528f162669368172ba0a588c41371a7a0327d9ce0f429121e7`

## ⑦docker compose upでアプリを起動する
`$ docker compose up`

## ⑧別タブで、`docker-compose run web rake db:create db:migrate`でDBを作成してマイグレーションする

## ⑨`http://localhost:3000`にアクセスしてシステムを動かしてみる

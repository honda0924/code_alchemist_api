FROM ruby:2.6.5

# 必要なパッケージのインストール（Rails6からWebpackerがいるので、yarnをインストールする）
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y build-essential libpq-dev nodejs yarn

# 作業ディレクトリの作成
RUN mkdir /code_alchemist_api
WORKDIR /code_alchemist_api

# ホスト側（ローカル）（左側）のGemfileを、コンテナ側（右側）のGemfileへ追加
ADD ./Gemfile /code_alchemist_api/Gemfile
ADD ./Gemfile.lock /code_alchemist_api/Gemfile.lock

# Gemfileのbundle install
RUN bundle install
ADD . /code_alchemist_api
FROM ruby:3.2.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
WORKDIR /myapp
COPY Gemfile Gemfile.lock /myapp/
RUN bundle install
ADD . /myapp
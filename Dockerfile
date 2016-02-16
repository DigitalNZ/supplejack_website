FROM ruby:2.3
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  npm \
  g++

RUN mkdir /app

# http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

WORKDIR /app

EXPOSE 3000
CMD rails s -b 0.0.0.0

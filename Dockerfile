FROM ruby:2.7.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs ghostscript

WORKDIR /app

RUN gem install bundler --version 2.2.5
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
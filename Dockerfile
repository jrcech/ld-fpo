FROM ruby:2.7.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs ghostscript libgmp3-dev ruby-dev libffi-dev

WORKDIR /app

RUN gem install ffi
RUN gem install psych
RUN gem install json
RUN gem install puma
RUN gem install bundler --version 2.2.5
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
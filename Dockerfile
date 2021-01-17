FROM ruby:2.7.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs ghostscript libgmp3-dev ruby-dev libffi-dev

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -y
RUN apt-get install yarn -y

WORKDIR /app

RUN gem install bundler --version 2.2.5
RUN gem install ffi psych json puma parser bindex debug_inspector

COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
RUN yarn install
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
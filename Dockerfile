FROM ruby:2.7.2

WORKDIR /app

ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true

COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test
COPY . .
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
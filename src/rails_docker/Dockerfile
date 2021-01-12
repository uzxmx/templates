# Find available versions at https://hub.docker.com/_/ruby
FROM ruby:2.7.1-alpine3.12

WORKDIR /app

COPY Gemfile* ./

# Use mirror for apk package
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  # For build essentials, e.g. gcc.
  && apk add --no-cache --virtual .build-deps build-base \
  # For mysql and timezone.
  && apk add --no-cache mariadb-dev tzdata \
  && bundle config mirror.https://rubygems.org https://gems.ruby-china.com \
  && bundle install --without development test \
  && apk del .build-deps

ARG RAILS_ENV=production

ENV RAILS_ENV="$RAILS_ENV" \
  LANG="en_US.UTF-8" \
  LANGUAGE="en_US.UTF-8" \
  LC_ALL="en_US.UTF-8" \
  TZ="Asia/Shanghai"

COPY app app
COPY bin bin
COPY config config
COPY db/migrate db/migrate
COPY lib lib
COPY public public
COPY vendor vendor
COPY config.ru Rakefile ./

RUN mkdir -p tmp log

COPY docker-entrypoint.sh /

expose 3000

CMD ["/docker-entrypoint.sh"]

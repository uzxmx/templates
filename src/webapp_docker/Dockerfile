## An ARG declared before a FROM is outside of a build stage,
## so it can’t be used in any instruction after a FROM.
## To use the default value of an ARG declared before the first
## FROM use an ARG instruction without a value inside of a build stage.
## Ref: https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
# ARG YOUR_ARG

# When the value of `CDN_HOST` is `CDN_HOST_STUB`, you can set an env variable
# `CDN_HOST_STUB_VALUE` to configure the CDN host on the fly when running the
# image.
ARG CDN_HOST

# Find available versions at https://hub.docker.com/_/node
FROM node:12.20.0-alpine3.12 AS build
ARG CDN_HOST

WORKDIR /app

# NPM mirrors
RUN npm set registry https://registry.npm.taobao.org \
  && npm set disturl https://npm.taobao.org/dist

## Optional NPM mirrors
# RUN npm set sass_binary_site https://npm.taobao.org/mirrors/node-sass \
#   && npm set electron_mirror https://npm.taobao.org/mirrors/electron/ \
#   && npm set puppeteer_download_host https://npm.taobao.org/mirrors \
#   && npm set chromedriver_cdnurl https://npm.taobao.org/mirrors/chromedriver \
#   && npm set operadriver_cdnurl https://npm.taobao.org/mirrors/operadriver \
#   && npm set phantomjs_cdnurl https://npm.taobao.org/mirrors/phantomjs \
#   && npm set selenium_cdnurl https://npm.taobao.org/mirrors/selenium \
#   && npm set node_inspector_cdnurl https://npm.taobao.org/mirrors/node-inspector

COPY package*.json ./

# Use mirror for apk package
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  # Git is required if there is a package in package.json which is downloaded by git.
  && apk add --no-cache --virtual .build-deps git \
  && npm ci \
  && apk del .build-deps

# COPY build build
# COPY config config
# COPY src src
# COPY static static
# COPY .babelrc .postcssrc.js index.html ./

# ARG NODE_ENV=production
# ARG YOUR_ARG

# ENV NODE_ENV=$NODE_ENV \
#     YOUR_VAR=$YOUR_ARG \
#     LANG="en_US.UTF-8" \
#     LANGUAGE="en_US.UTF-8" \
#     LC_ALL="en_US.UTF-8" \
#     TZ="Asia/Shanghai"

RUN npm run build

FROM nginx:1.19.6-alpine
ARG CDN_HOST

COPY --from=build /app/dist /app

COPY docker/app.conf /etc/nginx/conf.d/default.conf
COPY docker/docker-entrypoint.sh /

RUN mkdir -p /app/nginx/conf.d

ENV NGINX_API_PROXY_ENABLED
ENV NGINX_API_PROXY_URL
ENV CDN_HOST=$CDN_HOST
# ENV LANG="en_US.UTF-8" \
#     LANGUAGE="en_US.UTF-8" \
#     LC_ALL="en_US.UTF-8" \
#     TZ="Asia/Shanghai"

EXPOSE 80

CMD ["/docker-entrypoint.sh"]

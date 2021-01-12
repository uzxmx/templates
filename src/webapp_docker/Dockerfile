## Global ARG will be passed in each build stage.
# ARG YOUR_ARG

# Find available versions at https://hub.docker.com/_/node
FROM node:12.20.0-alpine3.12 AS build

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

COPY --from=build /app/dist /app

COPY docker/app.conf /etc/nginx/conf.d/default.conf
COPY docker/docker-entrypoint.sh /

RUN mkdir -p /app/nginx/conf.d

ENV API_PROXY_ENABLED
# ENV LANG="en_US.UTF-8" \
#     LANGUAGE="en_US.UTF-8" \
#     LC_ALL="en_US.UTF-8" \
#     TZ="Asia/Shanghai"

EXPOSE 80

CMD ["/docker-entrypoint.sh"]

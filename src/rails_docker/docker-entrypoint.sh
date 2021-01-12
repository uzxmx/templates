#!/bin/sh

set -e

mkdir -p tmp/pids

# TODO make this robust
bundle exec rake db:migrate
bundle exec puma -C config/puma.rb

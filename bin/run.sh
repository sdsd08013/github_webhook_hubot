#!/bin/sh

export PATH="node_modules/.bin:node_modules/hubot/node_modules/.bin:$PATH"
export HUBOT_SLACK_TOKEN=$RYUSHIMA_SLACK_TOKEN
export PORT=9999

forever start -c coffee node_modules/.bin/hubot --name "ryushima2" "$@" -a slack

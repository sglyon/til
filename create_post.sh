#!/bin/sh

if [ -z "$1" ]; then
  echo "Usage: $0 post_name"
  exit 1
fi

post_name=$1
date=$(date +%Y-%m-%d)
hugo new content/posts/${date}_${post_name}.md

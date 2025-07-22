#!/bin/bash

PROJECT_PATH="$1"
TAG1="$2"
TAG2="$3"

EXCLUDE="\.png$|\.pdf$|\.mp3$|\.woff2$|\.otf$|\.txt$|\.ttf$|\.jpeg$|\.jpg$|\.svg$"

cd "$PROJECT_PATH" || exit

# Lưu lại branch hiện tại
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

get_tag_info() {
    local tag=$1
    git log -1 --pretty=format:"%h - %s" $tag
}

count_lines_at_tag() {
    local tag=$1
    git checkout $tag --quiet
    git ls-files | grep -Ev "$EXCLUDE" | xargs wc -l | tail -1 | awk '{print $1}'
}

INFO1=$(get_tag_info "$TAG1")
COUNT1=$(count_lines_at_tag "$TAG1")

INFO2=$(get_tag_info "$TAG2")
COUNT2=$(count_lines_at_tag "$TAG2")

let DIFF=COUNT2-COUNT1

echo "Tag $INFO1: $COUNT1 dòng"
echo "Tag $INFO2: $COUNT2 dòng"
echo "Chênh lệch số dòng: $DIFF dòng"

# Quay lại branch ban đầu
git checkout $CURRENT_BRANCH --quiet

#!/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: ./publish.sh \"commit message\""
    exit 1;
fi

sculpin generate --env=prod

git stash
git checkout gh-pages

find . -path './output_prod' -prune -o -path './.*' -prune -o -path 'CNAME' -prune -o -path './app' -prune -o -name '*' -print | xargs rm -Rf
cp -R output_prod/* .
rm -rf output_prod

git add *
git commit -m "$1"
git push origin --all

git checkout master
git stash pop
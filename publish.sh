#!/bin/bash

if [ $# -ne 1 ]; then
    echo "usage: ./publish.sh \"commit message\""
    exit 1;
fi

sculpin generate --env=prod
if [ $? -ne 0 ]; then echo "Could not generate the site"; exit 1; fi

git stash
git checkout master

cp -R output_prod/* .
rm -rf output_*

git add *
git commit -m "$1"
git push origin master --force

git checkout sculpin
git stash pop

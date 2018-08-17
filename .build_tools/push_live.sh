#!/usr/bin/env bash

# stop on error
set -e
if [[ $TRAVIS_BRANCH == 'master' && $TRAVIS_PULL_REQUEST == 'false' ]]; then
    echo "==> Pushing to live repository"
    git push live HEAD:master
fi

#!/usr/bin/env bash

# stop on error
set -e
if [[ $TRAVIS_BRANCH == 'master' && $TRAVIS_PULL_REQUEST == 'false' ]]; then
    echo "==> Prepair update of live repository"
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
    echo "  ==> fetch master from origin"
    git fetch origin master
    git checkout master
    git pull --rebase origin master
    echo "  ==> fetch master from live"
    git fetch live master
    echo "  ==> update live's master with changes from origin"
    git checkout live/master
    git rebase origin/master
    ORIGIN_HEAD=`git log -1 --format="%H" origin/master`
    LIVE_HEAD=`git log -1 --format="%H" live/master`
    HEAD=`git log -1 --format="%H"`
    git log --graph --decorate --oneline | head
    if [[ "$ORIGIN_HEAD" == "$LIVE_HEAD" && "$LIVE_HEAD" == "$HEAD" ]]; then
        echo "  ==> All sanity checks pass"
        exit 0
    else
        echo "cannot sync repositories"
        echo "  ==> live"
        git log --oneline live/master | head
        echo "  ==> origin"
        git log --oneline origin/master | head
        echo "  ==> HEAD"
        git log --oneline | head
        exit 1
    fi
fi

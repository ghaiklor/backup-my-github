#!/usr/bin/env bash

set -e

RESET_COLOR="\\033[0m"
RED_COLOR="\\033[0;31m"
GREEN_COLOR="\\033[0;32m"
BLUE_COLOR="\\033[0;34m"

function reset_color() {
    echo -e "${RESET_COLOR}\\c"
}

function red_color() {
    echo -e "${RED_COLOR}\\c"
}

function green_color() {
    echo -e "${GREEN_COLOR}\\c"
}

function blue_color() {
    echo -e "${BLUE_COLOR}\\c"
}

function hello() {
    blue_color
    echo "                                              "
    echo "               Backup My GitHub               "
    echo "                 by @ghaiklor                 "
    echo "                                              "
    echo "This script will clone all your repositories from provided username to your machine"
    echo "It will prompt you for your username account and personal access token"
    echo "To generate token, please, refer this guide - https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line"
    echo "Make sure, that your token has full access to repo scope!"
    reset_color
}

function checkForCurl() {
    if ! [ "$(command -v curl)" ]; then
        red_color
        echo "You don't have installed curl"
        exit 1
    else
        green_color
        echo "curl is present on your machine, continue..."
    fi

    reset_color
}

function checkForJQ() {
    if ! [ "$(command -v jq)" ]; then
        red_color
        echo "You don't have installed jq"
        exit 1
    else
        green_color
        echo "jq is present on your machine, continue..."
    fi

    reset_color
}

function cloneRepositories() {
    green_color
    echo
    read -r -p "What is your username on GitHub: " username
    read -r -p "What is your personal access token: " token
    echo

    blue_color
    repository_count=$(curl -XGET -s https://"${username}":"${token}"@api.github.com/users/"${username}" | jq -c --raw-output ".public_repos")
    repositories=$(curl -XGET -s https://"${username}":"${token}"@api.github.com/users/"${username}"/repos?per_page="${repository_count}" | jq -c --raw-output ".[].ssh_url")

    for repository in ${repositories}; do
        echo "Cloning ${repository}..."
        git clone --quiet "${repository}"
    done

    green_color
    echo "All your repositories are successfully cloned in current directory"
}

hello
checkForCurl
checkForJQ
cloneRepositories

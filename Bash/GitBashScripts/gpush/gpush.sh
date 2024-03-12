#!/bin/bash

repository="$1"
sourceBranch="$2"

echo
url="https://bitbucket.org/<orgName>/${repository}/pull-requests/new?source=${sourceBranch}&dest=release\n"
echo $url
url="https://bitbucket.org/<orgName>/${repository}/pull-requests/new?source=${sourceBranch}&dest=develop\n"
echo $url
url="https://github.com/<orgName>/${repository}/compare/release...${sourceBranch}?quick_pull=1"
echo $url
url="https://github.com/<orgName>/${repository}/compare/develop...${sourceBranch}?quick_pull=1"
echo $url
echo

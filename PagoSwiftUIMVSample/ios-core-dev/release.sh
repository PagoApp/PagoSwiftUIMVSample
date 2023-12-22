#!/bin/bash


# setup

PROJECT_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

release() {

    VERSION_PATTERN="^(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)(\\-[0-9a-za-z-]+(\\.[0-9a-za-z-]+)*)?(\\+[0-9a-za-z-]+(\\.[0-9a-za-z-]+)*)?$"
    echo "\n"
    read -p "RELEASE VERSION (For example: 1.2.3) = " RELEASE_VERSION
    
    if [[ "$RELEASE_VERSION" =~ $VERSION_PATTERN ]]
    then
        git checkout -b "release/${RELEASE_VERSION}"
        git add .
        git commit -m "created release branch for ${RELEASE_VERSION}"
        git push --set-upstream origin "release/${RELEASE_VERSION}"
    else
        echo "ERROR: INVALID VERSION :("
    fi
}

release

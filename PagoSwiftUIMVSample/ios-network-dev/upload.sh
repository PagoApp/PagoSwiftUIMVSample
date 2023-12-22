#!/bin/bash


# setup

PROJECT_PATH=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

release() {

    VERSION_PATTERN="^(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)(\\-[0-9a-za-z-]+(\\.[0-9a-za-z-]+)*)?(\\+[0-9a-za-z-]+(\\.[0-9a-za-z-]+)*)?$"
    echo "\n"
    read -p "RELEASE VERSION (For example: 1.2.3) = " RELEASE_VERSION
    
    if [[ "$RELEASE_VERSION" =~ $VERSION_PATTERN ]]
    then
    
        SDK_NAME=$1
        BUILD_PATH="$PROJECT_PATH/build"
        FASTLANE_PATH="$PROJECT_PATH/fastlane"
        SPM_PROJECT_PATH="$PROJECT_PATH/ios-network-release"
        
        if [ -d "$BUILD_PATH" ] 
        then 
            cd $BUILD_PATH
            rm -Rf *
        fi
        
        cd $FASTLANE_PATH
        sh scripts/build.sh
        cd $BUILD_PATH
        zip -r $SDK_NAME.zip $SDK_NAME.xcframework
        cd $SPM_PROJECT_PATH
        gh release create $RELEASE_VERSION --title "$RELEASE_VERSION" --notes ""
        gh release upload $RELEASE_VERSION $BUILD_PATH/$SDK_NAME.zip
        gh release view $RELEASE_VERSION --json assets
        shasum -a 256 $BUILD_PATH/$SDK_NAME.zip | sed 's/ .*//'
    
    else
        echo "ERROR: INVALID VERSION :("
    fi
}

release PagoApiClient

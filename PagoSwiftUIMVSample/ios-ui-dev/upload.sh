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
        SPM_PROJECT_PATH="$PROJECT_PATH/ios-ui-release"
        
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

# Function to update the minimum deployment target for an Xcode project
update_deployment_target() {
    # Check if the project directory path is provided
    if [ -z "$1" ]; then
        echo "Usage: update_deployment_target <project_directory> <project_name> <new_deployment_target>"
        return 1
    fi

    # Check if a new deployment target is provided
    if [ -z "$2" ]; then
        echo "Usage: update_deployment_target <project_directory> <project_name> <new_deployment_target>"
        return 1
    fi
    
        # Check if a new deployment target is provided
    if [ -z "$3" ]; then
        echo "Usage: update_deployment_target <project_directory> <project_name> <new_deployment_target>"
        return 1
    fi

    local PROJECT_DIR="$1"
    local PROJECT_NAME="$2"
    local NEW_DEPLOYMENT_TARGET="$3"

    # Locate and update the minimum deployment target in the project file
    local PBXPROJ_FILE="${PROJECT_PATH}/${PROJECT_DIR}/${PROJECT_NAME}.xcodeproj/project.pbxproj"
    sed -i '' "s/IPHONEOS_DEPLOYMENT_TARGET = .*/IPHONEOS_DEPLOYMENT_TARGET = ${NEW_DEPLOYMENT_TARGET};/g" "${PBXPROJ_FILE}"

    echo "Minimum deployment target updated to ${NEW_DEPLOYMENT_TARGET}"
}

update_deployment_target "lottie-ios" "Lottie" "13.0"
update_deployment_target "SDWebImage" "SDWebImage" "13.0"
release PagoUISDK

#/bin/sh
xcodebuild archive \
-workspace '../PagoCoreSDK.xcworkspace' \
-scheme PagoCoreSDK \
-configuration Release \
-destination 'generic/platform=iOS Simulator' \
-archivePath '../build/PagoCoreSDK.framework-iphonesimulator.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
ENABLE_BITCODE=YES

xcodebuild archive \
-workspace '../PagoCoreSDK.xcworkspace' \
-scheme PagoCoreSDK \
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath '../build/PagoCoreSDK.framework-iphoneos.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
ENABLE_BITCODE=YES

xcodebuild -create-xcframework \
-framework '../build/PagoCoreSDK.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/PagoCoreSDK.framework' \
-framework '../build/PagoCoreSDK.framework-iphoneos.xcarchive/Products/Library/Frameworks/PagoCoreSDK.framework' \
-output '../build/PagoCoreSDK.xcframework'

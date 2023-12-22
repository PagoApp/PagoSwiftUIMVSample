#/bin/sh
xcodebuild archive \
-workspace '../PagoUI.xcworkspace' \
-scheme PagoUISDK \
-configuration Release \
-destination 'generic/platform=iOS Simulator' \
-archivePath '../build/PagoUISDK.framework-iphonesimulator.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
ENABLE_BITCODE=YES

xcodebuild archive \
-workspace '../PagoUI.xcworkspace' \
-scheme PagoUISDK \
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath '../build/PagoUISDK.framework-iphoneos.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
ENABLE_BITCODE=YES

xcodebuild -create-xcframework \
-framework '../build/PagoUISDK.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/PagoUISDK.framework' \
-framework '../build/PagoUISDK.framework-iphoneos.xcarchive/Products/Library/Frameworks/PagoUISDK.framework' \
-output '../build/PagoUISDK.xcframework'

#/bin/sh
xcodebuild archive \
-workspace '../PagoApiClient.xcworkspace' \
-scheme PagoApiClient \
-configuration Release \
-destination 'generic/platform=iOS Simulator' \
-archivePath '../build/PagoApiClient.framework-iphonesimulator.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
ENABLE_BITCODE=YES

xcodebuild archive \
-workspace '../PagoApiClient.xcworkspace' \
-scheme PagoApiClient \
-configuration Release \
-destination 'generic/platform=iOS' \
-archivePath '../build/PagoApiClient.framework-iphoneos.xcarchive' \
SKIP_INSTALL=NO \
BUILD_LIBRARIES_FOR_DISTRIBUTION=YES \
ENABLE_BITCODE=YES

xcodebuild -create-xcframework \
-framework '../build/PagoApiClient.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/PagoApiClient.framework' \
-framework '../build/PagoApiClient.framework-iphoneos.xcarchive/Products/Library/Frameworks/PagoApiClient.framework' \
-output '../build/PagoApiClient.xcframework'

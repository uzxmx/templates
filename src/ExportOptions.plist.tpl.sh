<!-- vi: set ft=xml : -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <!--
      Describes how Xcode should export the archive. Available options: app-store, validation, package, ad-hoc,
      enterprise, development, developer-id, and mac-application. The list of options varies based on the type
      of archive. Defaults to development.
    -->
    <key>method</key>
    <string>${EXPORT_METHOD:-development}</string>

    <!--
      For manual signing only. Specify the provisioning profile to use for each executable in
      your app. Keys in this dictionary are the bundle identifiers of executables; values are
      the provisioning profile name or UUID to use.
    -->
    <key>provisioningProfiles</key>
    <dict>
      <key>${EXPORT_PROVISION_PROFILE_KEY}</key>
      <string>${EXPORT_PROVISION_PROFILE_VALUE}</string>
    </dict>

    <!--
      For manual signing only. Provide a certificate name, SHA-1 hash, or automatic selector to use for signing.
      Automatic selectors allow Xcode to pick the newest installed certificate of a particular type. The available
      automatic selectors are "Mac App Distribution", "iOS Distribution", "iOS Developer", "Developer ID Application",
      "Apple Distribution", "Mac Developer", and "Apple Development". Defaults to an automatic certificate selector
      matching the current distribution method.
    -->
    <!-- <key>signingCertificate</key>       -->
    <!-- <string>Apple Distribution</string> -->

    <!--
      The signing style to use when re-signing the app for distribution. Options are manual or automatic. Apps
      that were automatically signed when archived can be signed manually or automatically during distribution,
      and default to automatic. Apps that were manually signed when archived must be manually signed during
      distribtion, so the value of signingStyle is ignored.
    -->
    <!-- <key>signingStyle</key> -->
    <!-- <string>manual</string> -->

    <!--
      The Developer Portal team to use for this export. Defaults to the team used to build the archive.
    -->
    <!-- <key>teamID</key>           -->
    <!-- <string>TEAM_ID</string> -->

    <!--
      For non-App Store exports, should Xcode re-compile the app from bitcode? Defaults to YES.
    -->
    <!-- <key>compileBitcode</key> -->
    <!-- <true/>                   -->

    <!--
      Determines whether the app is exported locally or uploaded to Apple. Options are export or upload.
      The available options vary based on the selected distribution method. Defaults to export.
    -->
    <key>destination</key>
    <string>export</string>

    <!--
      For App Store exports, should Xcode generate App Store Information for uploading with iTMSTransporter? Defaults to NO.
    -->
    <!-- <key>generateAppStoreInformation</key> -->
    <!-- <false/>                               -->

    <!--
      Should symbols be stripped from Swift libraries in your IPA? Defaults to YES.
    -->
    <key>stripSwiftSymbols</key>
    <${EXPORT_STRIP_SWIFT_SYMBOLS:-true}/>

    <!--
      For App Store exports, should the package include bitcode? Defaults to YES.
    -->
    <key>uploadBitcode</key>
    <${EXPORT_UPLOAD_BITCODE:-false}/>

    <!--
      For App Store exports, should the package include symbols? Defaults to YES.
    -->
    <key>uploadSymbols</key>
    <${EXPORT_UPLOAD_SYMBOLS:-true}/>
  </dict>
</plist>

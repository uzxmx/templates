<!-- vi: set ft=xml : -->
<!--
Jobs defined in ~/Library/LaunchAgents will be loaded on startup. For more info, please execute 'man launchd'.
Use 'man launchd.plist' to get more help on how to configure a daemon/agent file.
-->

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <!-- This required key uniquely identifies the job to launchd. -->
    <key>Label</key>
    <string>$(echo "$FILENAME" | sed -e 's/.plist$//')</string>

    <!-- When ProgramArguments is specified, the first element should be the absolute path to the executable. -->
    <key>ProgramArguments</key>
    <array>
      <string>/bin/date</string>
      <string>+DATE: %Y-%m-%d%nTIME: %H:%M:%S</string>
    </array>

    <!-- The file for stdout/stderr will be opened with append mode. -->
    <key>StandardOutPath</key>
    <string>/tmp/foo.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/foo.log</string>

    <!-- When RunAtLoad is true, the job will be launched automatically. -->
    <key>RunAtLoad</key>
    <true/>

    <!-- When KeepAlive is true, the job will be restarted when exit. -->
    <key>KeepAlive</key>
    <false/>
  </dict>
</plist>

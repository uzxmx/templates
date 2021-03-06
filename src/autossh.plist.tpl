<!-- vi: set ft=xml : -->
<!-- To make this work, you need to configure 'GatewayPorts yes' in sshd_config, see `man ssh`. -->
<?xml version=1.0 encoding=UTF-8?>
<!DOCTYPE plist PUBLIC -//Apple//DTD PLIST 1.0//EN http://www.apple.com/DTDs/PropertyList-1.0.dtd>
<plist version=1.0>
  <dict>
    <key>Label</key>
    <string>autossh</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/local/bin/autossh</string>
      <string>-M</string>
      <string>20000</string>
      <string>user@host</string>
      <string>-R</string>
      <string>REMOTE_PORT:localhost:LOCAL_PORT</string>
      <string>-N</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
  </dict>
</plist>

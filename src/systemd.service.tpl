# For more information, please visit https://www.freedesktop.org/software/systemd/man/systemd.service.html

[Unit]
Description=SERVICE_DESCRIPTION
After=network.target

[Service]
Type=simple
ExecStart=/bin/bash -c 'SERVICE_NAME &>/var/log/SERVICE_NAME.log'
# Stop the pid in a file.
ExecStartPost=/bin/bash -c 'umask 022; pgrep SERVICE_NAME >/var/run/SERVICE_NAME.pid'
KillMode=process
Restart=on-failure
RestartSec=1min

[Install]
WantedBy=multi-user.target

#!/bin/sh

set -e

PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
# Update the executable name.
NAME="executable_name"
if ! bin_path="$(which "$NAME")"; then
  echo $NAME not found
  exit
fi
pid_path="/var/run/$NAME.pid"
log_path="/var/log/$NAME.log"

. /lib/lsb/init-functions

start() {
  # Export environment variables to the daemon.
  export FOO=bar
  export BAR=baz

  ## Uncomment below if you want to run this daemon as a non-root user.
  ## Make the log writable by a normal user.
  # touch "$log_path" && chmod a+w "$log_path"

  # start-stop-daemon --start --quiet --oknodo \
  #   -c USER -g GROUP \
  #   -b --no-close \
  #   --pidfile "$pid_path" -m \
  #   --exec "$bin_path" -- --opt1 foo --opt2 bar >"$log_path" 2>&1

  # For more info, see `man start-stop-daemon`.
  start-stop-daemon --start --quiet --oknodo \
    -b --no-close \
    --pidfile "$pid_path" -m \
    --exec "$bin_path" -- --opt1 foo --opt2 bar >"$log_path" 2>&1
}

stop() {
  ## Uncomment below
  # start-stop-daemon --stop --quiet --oknodo \
  #   -c USER -g GROUP \
  #   --pidfile "$pid_path" --remove-pidfile

  start-stop-daemon --stop --quiet --oknodo \
    --pidfile "$pid_path" --remove-pidfile
}

case "$1" in
  start)
    start
    echo "$NAME started."
    ;;
  stop)
    stop
    echo "$NAME stopped."
    ;;
  status)
    status_of_proc -p "$pid_path" "$NAME" "$NAME"
    ;;
  restart|force-reload)
    stop
    start
    echo "$NAME restarted."
    ;;
  *)
    echo "Usage: /etc/init.d/$NAME {start|stop|restart|force-reload}" >&2
    exit 1
    ;;
esac

exit 0
# vi: ft=sh

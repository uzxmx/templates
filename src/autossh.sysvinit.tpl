#!/bin/sh

set -e

PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
NAME="autossh"
if ! bin_path="$(which "$NAME")"; then
  echo $NAME not found
  exit
fi
pid_path="/var/run/$NAME.pid"
log_path="/var/log/$NAME.log"

. /lib/lsb/init-functions

start() {
  export AUTOSSH_DEBUG=1
  export AUTOSSH_LOGLEVEL=7
  export AUTOSSH_POLL=60

  # Make the log writable by a normal user.
  touch "$log_path" && chmod a+w "$log_path"

  # For more info, see `man start-stop-daemon`.
  start-stop-daemon --start --quiet --oknodo \
    -c USER -g GROUP \
    -b --no-close \
    --pidfile "$pid_path" -m \
    --exec "$bin_path" -- -M 20000 REMOTE_USER@REMOTE_HOST -R 30022:localhost:22 -N >"$log_path" 2>&1
}

stop() {
  start-stop-daemon --stop --quiet --oknodo \
    -c USER -g GROUP \
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

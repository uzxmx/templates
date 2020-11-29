#!/usr/bin/env bash
#
# vi: ft=sh
# Template for a wrapper utility or plain old executable. Substitute `WRAPPER`
# with a real name, or do as the comments indicate.

set -eo pipefail

usage() {
  cat <<-EOF 1>&2
Wrapper for WRAPPER utility.

Subcommands:
  foo - foo command
  fzf - search a command by its description and execute
EOF
  exit 1
}

# Delete below snippet if you don't want a wrapper.
source ~/.dotfiles/scripts/lib/path.sh
PATH=$(new_path_exclude ~/.dotfiles/bin)

# Delete below snippet if you don't want a fzf sub command.
FZF_COMMANDS="Command description\techo foo
"

usage_foo() {
  cat <<-EOF 1>&2
Usage: WRAPPER foo <arg>

Some description.

Example:
  $> WRAPPER foo bar
EOF
  exit 1
}

cmd_foo() {
  echo foo
}

case "$1" in
  # Delete below snippet if you don't want a fzf sub command.
  fzf)
    source ~/.dotfiles/scripts/lib/cmd_fzf.sh
    ;&
    # Fall through

  foo)
    cmd="$1"
    shift
    case "$1" in
      -h)
        type "usage_$cmd" &>/dev/null && "usage_$cmd"
        ;;
    esac
    "cmd_$cmd" "$@"
    ;;

  ## Uncomment below snippet if you don't want a wrapper.
  # *)
  #   usage
  #   ;;

  # Delete below snippet if you don't want a wrapper.
  -h)
    usage
    ;;
  -)
    shift
    ;&
    # Fall through
  *)
    WRAPPER "$@"
    ;;
esac

#!/usr/bin/env bash
#
# vi: ft=sh
# Template for a wrapper utility or plain old executable. Substitute `WRAPPER`
# with a real name, or do as the comments indicate.

set -e

dotfiles_dir="$(realpath "$(dirname "$BASH_SOURCE")/..")"

usage() {
  cat <<-EOF
Wrapper for WRAPPER utility.

Subcommands:
  foo - foo command
  fzf - search a command by its description and execute
EOF
  exit 1
}

# Delete below snippet if you don't want a wrapper.
source "$dotfiles_dir/scripts/lib/path.sh"
PATH="$(new_path_exclude "$dotfiles_dir/bin")"

# Delete below snippet if you don't want a fzf sub command.
FZF_COMMANDS="Command description\techo foo
"

alias_cmd() {
  local new_name="$1"
  local old_name="$2"
  eval "
    usage_$new_name() {
      usage_$old_name \"\$@\"
    }
    cmd_$new_name() {
      cmd_$old_name \"\$@\"
    }
  "
}

process_common_options() {
  local -a remainder
  while [ "$#" -gt 0 ]; do
    case "$1" in
      -w)
        shift
        workspace="$2"
        ;;
      *)
        remainder+=("$1")
        ;;
    esac
    shift
  done

  set - "${remainder[@]}"
}

usage_foo() {
  cat <<-EOF
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

alias_cmd f foo

run() {
  local cmd="$1"
  shift
  case "$1" in
    -h)
      type "usage_$cmd" &>/dev/null && "usage_$cmd"
      ;;
  esac
  "cmd_$cmd" "$@"
}

case "$1" in
  # Delete below snippet if you don't want a fzf sub command.
  fzf)
    source "$dotfiles_dir/scripts/lib/cmd_fzf.sh"
    # The following line is commented to support old versions of bash.
    # ;&
    # Fall through
    run "$@"
    ;;

  foo)
    run "$@"
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
    # The following line is commented to support old versions of bash.
    # ;&
    # Fall through
    WRAPPER "$@"
    ;;
  *)
    WRAPPER "$@"
    ;;
esac

#!/usr/bin/env bash
#
# vi: ft=sh
# Template for installation script.

set -eo pipefail

usage() {
  cat <<-EOF
Usage: $0 [version]
EOF
  exit 1
}

remainder=()
while [ $# -gt 0 ]; do
  case "$1" in
    -*)
      usage
      ;;
    *)
      remainder+=("$1")
      ;;
  esac
  shift
done
set - "${remainder[@]}"

dotfiles_dir="$(realpath "$(dirname "$BASH_SOURCE")/../..")"

source "$dotfiles_dir/scripts/lib/path.sh"
PATH="$(new_path_exclude "$dotfiles_dir/bin")"

type -p NAME &> /dev/null && exit

source "$dotfiles_dir/scripts/lib/install.sh"

# if is_mac; then
#   brew_install NAME
#   exit
# fi

##################
# Install by git #
##################
dir="/tmp/NAME"
git_clone GIT_URL "$dir" --branch BRANCH_OR_TAG --depth 1

cd "$dir"
sh autogen.sh
./configure
make
sudo make install
rm -rf "$dir"

####################
# Install by http  #
####################
version="VERSION"
path_to_save="/tmp/NAME-$version.tar.xz"
if is_mac; then
  platform="macosx"
elif is_linux; then
  platform="linux"
else
  abort "Unsupported system"
fi

"$dotfiles_dir/bin/cget" "$platform-$version.tar.xz" "$path_to_save"

cd /tmp && tar Jxf "$path_to_save"

dir="/tmp/NAME-$version"
cd "$dir"
./configure
make
sudo make install

rm -rf "$dir" "$path_to_save"

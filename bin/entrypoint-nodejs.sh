#!/usr/bin/env bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : 202202021753-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.com
# @License       : WTFPL
# @ReadME        : entrypoint.sh --help
# @Copyright     : Copyright: (c) 2022 Jason Hempstead, Casjays Developments
# @Created       : Wednesday, Feb 02, 2022 17:53 EST
# @File          : entrypoint.sh
# @Description   :
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
APPNAME="$(basename "$0")"
VERSION="202202021753-git"
USER="${SUDO_USER:-${USER}}"
HOME="${USER_HOME:-${HOME}}"
SRC_DIR="${BASH_SOURCE%/*}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set bash options
if [[ "$1" == "--debug" ]]; then shift 1 && set -xo pipefail && export SCRIPT_OPTS="--debug" && export _DEBUG="on"; fi
trap 'exitCode=${exitCode:-$?};[ -n "$ENTRYPOINT_SH_TEMP_FILE" ] && [ -f "$ENTRYPOINT_SH_TEMP_FILE" ] && rm -Rf "$ENTRYPOINT_SH_TEMP_FILE" &>/dev/null' EXIT

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
export NODE_VERSION="${NODE_VERSION:-system}"
export FNM_INTERACTIVE_CLI="false"
export PATH="/root/.local/state/fnm_multishells/408_1643940963309/bin":$PATH
export FNM_MULTISHELL_PATH="/root/.local/state/fnm_multishells/408_1643940963309"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_DIR="/root/.local/share/fnm"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_LOGLEVEL="debug"
export TZ="${TZ:-America/New_York}"
export HOSTNAME="${HOSTNAME:-casjaysdev-nodejs}"

[ -n "${TZ}" ] && echo "${TZ}" >/etc/timezone
[ -n "${HOSTNAME}" ] && echo "${HOSTNAME}" >/etc/hostname
[ -n "${HOSTNAME}" ] && echo "127.0.0.1 $HOSTNAME localhost" >/etc/hosts
[ -f "/usr/share/zoneinfo/${TZ}" ] && ln -sf "/usr/share/zoneinfo/${TZ}" "/etc/localtime"

[ -f "$HOME/.profile" ] && . "$HOME/.profile"
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
[ -f "/app/.env" ] && . "/app/.env"

case "$1" in
healthcheck)
  echo 'OK'
  ;;
bash | shell | sh)
  exec /bin/bash -l
  ;;

npm | yarn | node | nodemon)
  exec "$@"
  exit
  ;;
*)
  echo 'Initializing the nodejs environment'
  if [ -f "$(type -P fnm 2>/dev/null)" ]; then
    echo "Initializing fnm..."
    [ -f "/app/.node_version" ] && [ -z "$NODE_VERSION" ] &&
      export NODE_VERSION="$(</app/.node_version)"
    if [[ "$NODE_VERSION" != "system" ]]; then
      fnm install $NODE_VERSION
      fnm use $NODE_VERSION
      fnm default $NODE_VERSION
    fi
  fi
  [ -d "/app" ] && cd /app || false
  [ -f "/app/.env" ] && . "/app/.env"
  if [ -f "/app/package.json" ]; then
    screenjs
  else
    bash -l
  fi
  ;;
esac

#!/usr/bin/env bash

set -euo pipefail

tool="${HOME}/.local/bin/asdbctl-xdr"
signal="RTMIN+11"
step="${XDR_BRIGHTNESS_STEP:-5}"

refresh_waybar() {
  pkill -"${signal}" waybar >/dev/null 2>&1 || true
}

get_brightness() {
  "${tool}" get 2>/dev/null | awk '/^brightness / { value = $2 } END { if (value != "") print value }'
}

show_json() {
  local brightness icon class
  brightness="$(get_brightness)"
  brightness="${brightness:-?}"

  if [[ "${brightness}" == "?" ]]; then
    printf '{"text":"󰃞","tooltip":"Studio Display XDR brightness unavailable","class":"error"}\n'
    exit 0
  fi

  if (( brightness >= 67 )); then
    icon="󰃠"
  elif (( brightness >= 34 )); then
    icon="󰃟"
  else
    icon="󰃞"
  fi

  class="dim"
  if (( brightness >= 67 )); then
    class="bright"
  elif (( brightness >= 34 )); then
    class="mid"
  fi

  printf '{"text":"%s","tooltip":"Studio Display XDR\\nHardware brightness: %s%%\\nScroll to adjust","class":"%s"}\n' \
    "${icon}" "${brightness}" "${class}"
}

adjust() {
  local direction="$1"
  "${tool}" "${direction}" --step "${step}" >/dev/null
  refresh_waybar
}

case "${1:-show}" in
  show)
    show_json
    ;;
  up)
    adjust up
    ;;
  down)
    adjust down
    ;;
  *)
    echo "usage: $0 [show|up|down]" >&2
    exit 1
    ;;
esac

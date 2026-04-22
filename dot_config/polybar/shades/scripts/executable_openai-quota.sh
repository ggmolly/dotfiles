#!/usr/bin/env bash

set -u

auth_path="${OPENCODE_AUTH_JSON:-$HOME/.local/share/opencode/auth.json}"
interval="${OPENAI_POLYBAR_INTERVAL:-120}"

read_auth() {
  jq -r '[.openai.access // "", .openai.accountId // ""] | @tsv' "$auth_path"
}

query_usage() {
  curl -fsS \
    -H "Authorization: Bearer $1" \
    -H "ChatGPT-Account-Id: $2" \
    "https://chatgpt.com/backend-api/wham/usage"
}

while true; do
  if [ ! -r "$auth_path" ]; then
    printf '󱎫 ? 󰸗 ?\n'
    sleep "$interval"
    continue
  fi

  if ! IFS=$'\t' read -r token account <<EOF
$(read_auth 2>/dev/null)
EOF
  then
    printf '󱎫 ? 󰸗 ?\n'
    sleep "$interval"
    continue
  fi

  if [ -z "$token" ] || [ -z "$account" ]; then
    printf '󱎫 ? 󰸗 ?\n'
    sleep "$interval"
    continue
  fi

  if ! usage="$(query_usage "$token" "$account" 2>/dev/null)"; then
    printf '󱎫 ? 󰸗 ?\n'
    sleep "$interval"
    continue
  fi

  if ! IFS=$'\t' read -r five_hours weekly weekly_reset_seconds <<EOF
$(jq -r '[.rate_limit.primary_window.used_percent, .rate_limit.secondary_window.used_percent, .rate_limit.secondary_window.reset_after_seconds] | @tsv' <<< "$usage" 2>/dev/null)
EOF
  then
    printf '󱎫 ? 󰸗 ?\n'
    sleep "$interval"
    continue
  fi

  weekly_days=$(( (weekly_reset_seconds + 86399) / 86400 ))
  printf '󱎫 %s%% 󰸗 %s%% • %sd\n' "$five_hours" "$weekly" "$weekly_days"
  sleep "$interval"
done

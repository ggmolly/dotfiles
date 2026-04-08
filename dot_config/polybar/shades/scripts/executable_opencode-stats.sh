#!/usr/bin/env bash

set -u

db_path="${OPENCODE_DB:-$HOME/.local/share/opencode/opencode.db}"
interval="${OPENCODE_POLYBAR_INTERVAL:-30}"

format_count() {
  awk -v n="$1" '
    BEGIN {
      if (n >= 1000000) {
        printf "%.1fM", n / 1000000
        exit
      }
      if (n >= 1000) {
        printf "%.1fK", n / 1000
        exit
      }
      printf "%d", n
    }
  '
}

query_stats() {
  sqlite3 -noheader "$db_path" "
    WITH day AS (
      SELECT
        (strftime('%s', 'now', 'localtime', 'start of day') * 1000) AS start_ms,
        (strftime('%s', 'now', 'localtime', 'start of day', '+1 day') * 1000) AS end_ms
    )
    SELECT
      (SELECT COUNT(*)
       FROM session s, day
       WHERE s.time_created >= day.start_ms
         AND s.time_created < day.end_ms) || '|' ||
      (SELECT COALESCE(SUM(CAST(json_extract(m.data, '$.tokens.input') AS INTEGER)), 0)
       FROM message m, day
       WHERE m.time_created >= day.start_ms
         AND m.time_created < day.end_ms) || '|' ||
      (SELECT COALESCE(SUM(CAST(json_extract(m.data, '$.tokens.output') AS INTEGER)), 0)
       FROM message m, day
       WHERE m.time_created >= day.start_ms
         AND m.time_created < day.end_ms);
  "
}

while true; do
  if [ ! -r "$db_path" ]; then
    printf 'db missing\n'
    sleep "$interval"
    continue
  fi

  if ! stats="$(query_stats 2>/dev/null)"; then
    printf 'db error\n'
    sleep "$interval"
    continue
  fi

  IFS='|' read -r sessions input output <<< "$stats"

  printf '  %s 󰍡 %s 󰍢 %s\n' \
    "$sessions" \
    "$(format_count "$input")" \
    "$(format_count "$output")"

  sleep "$interval"
done

#!/usr/bin/env bash
# docker-menu — compose service launcher via walker
# Set DOCKER_DIR env var to override the default location.

DOCKER_DIR="${DOCKER_DIR:-$HOME/docker}"
WALKER_CMD="walker --dmenu"

# ── Discover compose projects ─────────────────────────────────────────────────
# Returns full paths to compose files (supports both .yml and .yaml).
# Parentheses fix -o operator precedence in find.

get_compose_files() {
  find "$DOCKER_DIR" \( -name "docker-compose.yml" -o -name "docker-compose.yaml" \) 2>/dev/null \
    | sort
}

# ── Build menu ────────────────────────────────────────────────────────────────

build_menu() {
  local compose_files
  compose_files=$(get_compose_files)

  if [ -z "$compose_files" ]; then
    notify-send "Docker" "No compose projects found in $DOCKER_DIR"
    exit 1
  fi

  echo "⟳  Restart all"
  echo "↓  Stop all"
  echo "────────────────"

  while IFS= read -r compose_file; do
    local dir name running total
    dir=$(dirname "$compose_file")
    name=$(basename "$dir")
    running=$(docker compose -f "$compose_file" ps --services --filter status=running 2>/dev/null | wc -l)
    total=$(docker compose -f "$compose_file" ps --services 2>/dev/null | wc -l)

    if [ "$running" -gt 0 ]; then
      echo "◉  ${name}  [${running}/${total} running]|stop|${compose_file}"
    else
      echo "○  ${name}  [stopped]|start|${compose_file}"
    fi
  done <<< "$compose_files"

  echo "────────────────"
  echo "📋  lazydocker|lazy|"
}

# ── Handle selection ──────────────────────────────────────────────────────────

MENU=$(build_menu)
SELECTED=$(echo "$MENU" | $WALKER_CMD -p "Docker")
[ -z "$SELECTED" ] && exit 0

case "$SELECTED" in
  "⟳  Restart all")
    notify-send "Docker" "Restarting all services..."
    get_compose_files | while IFS= read -r f; do
      docker compose -f "$f" up -d 2>/dev/null
    done
    notify-send "Docker" "All services restarted"
    exit 0
    ;;
  "↓  Stop all")
    notify-send "Docker" "Stopping all services..."
    get_compose_files | while IFS= read -r f; do
      docker compose -f "$f" down 2>/dev/null
    done
    notify-send "Docker" "All services stopped"
    exit 0
    ;;
  "📋  lazydocker|lazy|")
    alacritty -e lazydocker &
    exit 0
    ;;
esac

if [[ "$SELECTED" == *"|start|"* ]]; then
  COMPOSE_FILE="${SELECTED##*|start|}"
  NAME=$(basename "$(dirname "$COMPOSE_FILE")")
  notify-send "Docker" "Starting ${NAME}..."
  if docker compose -f "$COMPOSE_FILE" up -d 2>/dev/null; then
    notify-send "Docker" "${NAME} is up"
  else
    notify-send "Docker Error" "${NAME} failed — check: docker compose -f $COMPOSE_FILE logs"
  fi

elif [[ "$SELECTED" == *"|stop|"* ]]; then
  COMPOSE_FILE="${SELECTED##*|stop|}"
  NAME=$(basename "$(dirname "$COMPOSE_FILE")")
  notify-send "Docker" "Stopping ${NAME}..."
  docker compose -f "$COMPOSE_FILE" down 2>/dev/null
  notify-send "Docker" "${NAME} stopped"
fi

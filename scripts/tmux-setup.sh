#!/usr/bin/env bash

set -euo pipefail

readonly BOLD='\033[1m'
readonly DIM='\033[2m'
readonly GREEN='\033[32m'
readonly BLUE='\033[34m'
readonly YELLOW='\033[33m'
readonly GRAY='\033[90m'
readonly NC='\033[0m'

readonly SESSION_NAME="dev"

SPINNER_PID=""

start_spinner() {
  local status_text="$1"
  local spinner_frames="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"

  {
    while true; do
      for ((i = 0; i < ${#spinner_frames}; i++)); do
        printf "\r${DIM}${spinner_frames:$i:1}${NC} %s" "$status_text"
        sleep 0.08
      done
    done
  } &
  SPINNER_PID=$!
}

stop_spinner() {
  if [[ -n "$SPINNER_PID" ]]; then
    kill "$SPINNER_PID" 2>/dev/null && wait "$SPINNER_PID" 2>/dev/null || true
    SPINNER_PID=""
  fi
  printf "\r\033[K"
}

log_header() {
  printf "\n${BOLD}%s${NC}\n" "$1"
}

log_success() {
  printf "${GREEN}✓${NC} %s\n" "$1"
}

log_step() {
  printf "${BLUE}→${NC} %s\n" "$1"
}

log_skip() {
  printf "${YELLOW}○${NC} %s\n" "$1"
}

log_muted() {
  printf "${DIM}%s${NC}\n" "$1"
}

handle_exit() {
  stop_spinner
  printf "\n"
}

trap handle_exit EXIT INT TERM

verify_tmux_installed() {
  log_step "Checking TMUX installation"

  if ! command -v tmux >/dev/null 2>&1; then
    log_muted "Error: TMUX not found"
    exit 1
  fi

  log_success "Ready"
}

create_tmux_session() {
  if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    log_skip "Session '$SESSION_NAME' already exists"
    return
  fi

  log_step "Creating TMUX session"
  start_spinner "Setting up workspace layout"

  # Create new session with main window
  tmux new-session -d -s "$SESSION_NAME" -n main

  # Split layout: main pane on left, two smaller panes on right
  local main_pane_id=0
  tmux split-window -h -p 10 -t "$main_pane_id"
  tmux select-pane -t "$main_pane_id"
  tmux split-window -v -p 10 -t "$main_pane_id"
  tmux select-pane -t "$main_pane_id"

  stop_spinner
  log_success "Created session '$SESSION_NAME'"
}

attach_to_tmux_session() {
  log_step "Attaching to session '$SESSION_NAME'"

  # Small delay for visual feedback before attaching
  sleep 0.3

  tmux attach-session -t "$SESSION_NAME"
}

main() {
  clear
  log_header "TMUX Session Manager"
  printf "\n"

  verify_tmux_installed
  create_tmux_session
  attach_to_tmux_session
}

main "$@"

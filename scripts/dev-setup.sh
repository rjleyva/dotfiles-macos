#!/usr/bin/env bash

set -euo pipefail

readonly BOLD='\033[1m'
readonly DIM='\033[2m'
readonly GREEN='\033[32m'
readonly BLUE='\033[34m'
readonly YELLOW='\033[33m'
readonly GRAY='\033[90m'
readonly NC='\033[0m'

readonly DOTFILES_DIRECTORY="$HOME/dotfiles-macos"
readonly DOTFILES_REPOSITORY_URL="${DOTFILES_REPO:-https://github.com/rjleyva/dotfiles-macos.git}"

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

install_xcode_command_line_tools() {
  log_step "Installing Xcode command line tools"

  if xcode-select -p &>/dev/null; then
    log_skip "Xcode command line tools already installed"
    return
  fi

  start_spinner "Installing Xcode CLI tools (this may take several minutes)"
  xcode-select --install 2>/dev/null || true

  # Wait for installation to complete
  while ! xcode-select -p &>/dev/null; do
    sleep 10
  done

  stop_spinner
  log_success "Successfully installed Xcode command line tools"
}

install_homebrew_package_manager() {
  local system_architecture
  local homebrew_prefix

  system_architecture="$(uname -m)"
  homebrew_prefix="/opt/homebrew"

  # Intel Macs use different prefix
  if [[ "$system_architecture" != "arm64" ]]; then
    homebrew_prefix="/usr/local"
  fi

  log_step "Installing Homebrew package manager"

  if command -v brew &>/dev/null; then
    log_skip "Homebrew package manager already installed"
  else
    start_spinner "Downloading and installing Homebrew package manager"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >/dev/null 2>&1
    stop_spinner
    log_success "Successfully installed Homebrew package manager"
  fi

  # Configure shell environment for Homebrew
  log_step "Configuring shell environment for Homebrew"
  if ! grep -q "brew shellenv" "$HOME/.zprofile" 2>/dev/null; then
    echo "eval \"\$($homebrew_prefix/bin/brew shellenv)\"" >>"$HOME/.zprofile"
    log_success "Added Homebrew to shell profile configuration"
  else
    log_skip "Homebrew shell environment already configured"
  fi

  # Load Homebrew into current session and export to subshells
  eval "$($homebrew_prefix/bin/brew shellenv)"
  export PATH

  # Disable analytics and update
  log_step "Updating Homebrew package definitions"
  start_spinner "Disabling analytics and fetching latest package definitions"
  brew analytics off >/dev/null 2>&1
  brew update >/dev/null 2>&1
  brew upgrade >/dev/null 2>&1
  stop_spinner
  log_success "Successfully updated Homebrew package definitions"
}

install_command_line_packages() {
  local cli_package_names=(
    stow node git neovim tmux
    lua-language-server marksman go python pipx
    ripgrep bat black ruff isort codespell shfmt stylua yq
    zoxide zsh-autosuggestions delta zsh-syntax-highlighting
    powerlevel10k eza tree tlrc
  )

  log_step "Installing command line packages via Homebrew"
  start_spinner "Installing CLI tools and development utilities"

  local packages_installed=0
  for package_name in "${cli_package_names[@]}"; do
    if ! brew list "$package_name" >/dev/null 2>&1; then
      brew install "$package_name" >/dev/null 2>&1
      ((packages_installed++))
    fi
  done

  stop_spinner
  if [[ $packages_installed -eq 0 ]]; then
    log_skip "All command line packages already installed"
  else
    log_success "Successfully installed $packages_installed command line packages"
  fi
}

install_nerd_fonts() {
  local nerd_font_names=(
    font-lilex-nerd-font
  )

  log_step "Installing Nerd Fonts for terminal"
  start_spinner "Installing programming fonts with icon support"

  local fonts_installed=0
  for font_name in "${nerd_font_names[@]}"; do
    if ! brew list --cask "$font_name" >/dev/null 2>&1; then
      brew install --cask "$font_name" >/dev/null 2>&1
      ((fonts_installed++))
    fi
  done

  stop_spinner
  if [[ $fonts_installed -eq 0 ]]; then
    log_skip "All Nerd Fonts already installed"
  else
    log_success "Successfully installed $fonts_installed Nerd Fonts"
  fi
}

install_go_language_tools() {
  log_step "Installing Go language development tools"
  start_spinner "Installing gopls language server and goimports formatter"

  local tools_installed=0

  # Install gopls (Go language server)
  if ! go list -m golang.org/x/tools/gopls >/dev/null 2>&1; then
    go install golang.org/x/tools/gopls@latest >/dev/null 2>&1
    ((tools_installed++))
  fi

  # Install goimports (Go import formatter)
  if ! command -v goimports &>/dev/null; then
    go install golang.org/x/tools/cmd/goimports@latest >/dev/null 2>&1
    ((tools_installed++))
  fi

  stop_spinner
  if [[ $tools_installed -eq 0 ]]; then
    log_skip "All Go language tools already installed"
  else
    log_success "Successfully installed $tools_installed Go language tools"
  fi
}

install_npm_language_servers() {
  local npm_package_names=(
    @olrtg/emmet-language-server
    @vtsls/language-server
    @astrojs/language-server
    svelte-language-server
    eslint_d prettier pyright
    graphql-language-service-cli
    vscode-langservers-extracted
    yaml-language-server
    typescript
  )

  log_step "Installing npm language servers and formatters"
  start_spinner "Installing JavaScript/TypeScript development tooling"

  local packages_installed=0
  for package_name in "${npm_package_names[@]}"; do
    if ! npm list -g --depth=0 "$package_name" >/dev/null 2>&1; then
      npm install -g "$package_name" >/dev/null 2>&1
      ((packages_installed++))
    fi
  done

  stop_spinner
  if [[ $packages_installed -eq 0 ]]; then
    log_skip "All npm language servers already installed"
  else
    log_success "Successfully installed $packages_installed npm language servers"
  fi
}

clone_dotfiles_repository() {
  # Check if we're currently in the correct git repository
  if git rev-parse --git-dir >/dev/null 2>&1; then
    local current_remote
    current_remote=$(git remote get-url origin 2>/dev/null || echo "")
    if [[ "$current_remote" == *"$DOTFILES_REPOSITORY_URL"* ]] || [[ "$current_remote" == *"$DOTFILES_REPO"* ]]; then
      log_skip "Already in the correct dotfiles-macos repository"
      return
    fi
  fi

  # Check if target directory exists and is the correct repository
  if [[ -d "$DOTFILES_DIRECTORY" ]] && [[ -d "$DOTFILES_DIRECTORY/.git" ]]; then
    pushd "$DOTFILES_DIRECTORY" >/dev/null
    local existing_remote
    existing_remote=$(git remote get-url origin 2>/dev/null || echo "")
    popd >/dev/null
    if [[ "$existing_remote" == *"$DOTFILES_REPOSITORY_URL"* ]] || [[ "$existing_remote" == *"$DOTFILES_REPO"* ]]; then
      log_skip "dotfiles-macos repository directory already exists and is correct"
      return
    else
      log_muted "Warning: $DOTFILES_DIRECTORY exists but is not the correct repository"
      # Could optionally backup/remove the existing directory
    fi
  fi

  log_step "Cloning dotfiles-macos repository from GitHub"
  start_spinner "Downloading configuration files from $DOTFILES_REPOSITORY_URL"

  if git clone "$DOTFILES_REPOSITORY_URL" "$DOTFILES_DIRECTORY" >/dev/null 2>&1; then
    stop_spinner
    log_success "Successfully cloned dotfiles-macos repository from GitHub"
  else
    stop_spinner
    log_muted "Error: Failed to clone dotfiles-macos repository from GitHub"
    exit 1
  fi
}

link_dotfiles_with_stow() {
  if [[ ! -d "$DOTFILES_DIRECTORY" ]]; then
    log_muted "Error: dotfiles-macos directory not found at $DOTFILES_DIRECTORY"
    exit 1
  fi

  log_step "Linking dotfiles-macos configuration files"
  start_spinner "Creating symbolic links for dotfiles-macos configuration files"

  pushd "$DOTFILES_DIRECTORY" >/dev/null
  stow . >/dev/null 2>&1
  popd >/dev/null

  stop_spinner
  log_success "Successfully linked dotfiles-macos configuration files with stow"

  # Rebuild bat cache if available
  if command -v bat &>/dev/null; then
    start_spinner "Rebuilding bat syntax highlighting cache"
    bat cache --build >/dev/null 2>&1
    stop_spinner
    log_success "Successfully rebuilt bat syntax highlighting cache"
  fi
}

make_scripts_executable() {
  local scripts_directory="$DOTFILES_DIRECTORY/scripts"

  if [[ ! -d "$scripts_directory" ]]; then
    log_skip "dotfiles-macos scripts directory not found"
    return
  fi

  log_step "Making dotfiles-macos scripts executable"
  start_spinner "Setting execute permissions on shell scripts in dotfiles-macos"

  chmod +x "$scripts_directory"/*.sh 2>/dev/null

  stop_spinner
  log_success "Successfully made dotfiles-macos scripts executable"
}

prepare_neovim_environment() {
  log_step "Preparing Neovim development environment"
  log_success "Neovim environment ready (launch nvim to install plugins)"
}

main() {
  clear
  log_header "macOS Development Environment Setup"
  printf "\n"

  install_xcode_command_line_tools
  install_homebrew_package_manager
  install_command_line_packages
  install_nerd_fonts
  install_go_language_tools
  install_npm_language_servers
  clone_dotfiles_repository
  link_dotfiles_with_stow
  make_scripts_executable
  prepare_neovim_environment

  printf "\n"
  log_header "macOS Development Environment Setup Complete"
  printf "\n${GREEN}✓${NC} ${DIM}Development environment ready for use${NC}\n"
}

main "$@"

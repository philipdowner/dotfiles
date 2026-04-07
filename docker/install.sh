#!/bin/sh
#
# docker/install.sh
#
# Installs Docker Engine + Compose plugin from Docker's official apt repo on
# Debian/Ubuntu. No-op on macOS (Docker Desktop is handled by the Brewfile).

set -e

# Linux only
if [ "$(uname -s)" != "Linux" ]; then
  exit 0
fi

if ! command -v apt-get >/dev/null 2>&1; then
  exit 0
fi

# Already installed?
if command -v docker >/dev/null 2>&1; then
  echo "docker/install.sh: docker already installed, skipping"
  exit 0
fi

echo "› installing Docker Engine"

# Determine distro id (ubuntu / debian)
. /etc/os-release
DISTRO="${ID:-ubuntu}"
CODENAME="${VERSION_CODENAME:-$(lsb_release -cs 2>/dev/null || echo stable)}"

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL "https://download.docker.com/linux/${DISTRO}/gpg" \
  | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/${DISTRO} ${CODENAME} stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt-get update -y
sudo apt-get install -y \
  docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin

# Add current user to docker group so docker can run without sudo.
if ! id -nG "$USER" | grep -qw docker; then
  echo "› adding $USER to docker group (log out/in for this to take effect)"
  sudo usermod -aG docker "$USER"
fi

echo "docker/install.sh: done"

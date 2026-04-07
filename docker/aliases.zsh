alias d='docker'
# `docker compose` (v2 plugin) is preferred; fall back to legacy docker-compose.
if docker compose version >/dev/null 2>&1; then
  alias d-c='docker compose'
else
  alias d-c='docker-compose'
fi

#!/usr/bin/env bash
# TimeGuessr Deutschland – Deploy auf dem Apache-Server.
#
# Der DocumentRoot (/var/www/timeguessr) ist ein Klon des Repos
# MWeisenauer/timeguessr-de. Dieses Skript holt den neuesten Stand.
#
# Aufruf (als root):   sudo /var/www/timeguessr/deploy.sh
# Optional anderes Zielverzeichnis:  sudo ./deploy.sh /pfad/zum/docroot
set -euo pipefail

ZIEL="${1:-/var/www/timeguessr}"
cd "$ZIEL"

# Erlaubt git das Pull auch, wenn der Ordner einem anderen Nutzer gehört
# (z. B. www-data) und das Skript als root läuft.
git config --global --add safe.directory "$ZIEL" 2>/dev/null || true

echo "→ Hole neuesten Stand aus dem Repo …"
git pull --ff-only

echo "✓ Deploy fertig: $(git log --oneline -1)"

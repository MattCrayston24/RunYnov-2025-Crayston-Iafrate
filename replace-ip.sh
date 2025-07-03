#!/bin/bash

# CONFIGURATION
OLD_IP="10.15.6.135"  # <-- Ton ancienne IP ici

read -p "💻 Entre ta nouvelle IP locale (ex: 192.168.1.100) : " NEW_IP

if [[ -z "$NEW_IP" ]]; then
  echo "❌ IP vide. Abandon."
  exit 1
fi

echo "🔄 Remplacement de $OLD_IP par $NEW_IP dans tous les fichiers .ts, .tsx, .js..."

# On remplace dans Backend, Frontend et App
grep -rl "$OLD_IP" ./App ./Backend ./Frontend | while read -r file; do
  sed -i'' -e "s|$OLD_IP|$NEW_IP|g" "$file"
done

echo "✅ IP mise à jour dans tous les fichiers !"

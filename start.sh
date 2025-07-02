#!/bin/bash

# Chemins relatifs vers les dossiers
BACKEND_DIR="./Backend"
APP_DIR="./App"
FRONTEND_DIR="./Frontend"

# Vérifie que les commandes nécessaires sont dispo
command -v npm >/dev/null 2>&1 || { echo >&2 "❌ npm n'est pas installé."; exit 1; }
command -v npx >/dev/null 2>&1 || { echo >&2 "❌ npx n'est pas installé."; exit 1; }

# Ouvre 3 terminaux pour chaque partie du projet
echo "🚀 Lancement des services..."

# Backend
gnome-terminal -- bash -c "cd $BACKEND_DIR && npm install && npm run dev; exec bash"
echo "🔑 Insertion d'un compte admin (si non existant)..."
node Backend/seedAdmin.js


# App mobile
gnome-terminal -- bash -c "cd $APP_DIR && npm install && npx expo start; exec bash"

# Frontend admin
gnome-terminal -- bash -c "cd $FRONTEND_DIR && npm install && npm run dev; exec bash"

echo "✅ Tous les services sont en cours de lancement."

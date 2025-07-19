#!/bin/bash

# Automatisches Backup der globalen Memories zu GitHub
echo "☁️ Backup globale Memories zu GitHub..."

# Backup-Verzeichnis
BACKUP_DIR="/Users/markosimic/memories-backup"
MEMORIES_FILE="/Users/markosimic/.cursor/memories/global-memories.jsonl"

# Prüfe ob Backup-Verzeichnis existiert
if [ ! -d "$BACKUP_DIR" ]; then
    echo "❌ Backup-Verzeichnis nicht gefunden: $BACKUP_DIR"
    exit 1
fi

# Kopiere aktuelle Memory-Datei
echo "📁 Kopiere Memory-Datei..."
cp "$MEMORIES_FILE" "$BACKUP_DIR/"

# Wechsle ins Backup-Verzeichnis
cd "$BACKUP_DIR"

# Git-Operationen
echo "🔄 Git-Operationen..."
git add .
git commit -m "Backup: Globale Memories $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main

# Status prüfen
if [ $? -eq 0 ]; then
    echo "✅ Backup erfolgreich zu GitHub hochgeladen!"
    echo "📊 Repository: https://github.com/suma-simic/memories"
    echo "📅 Backup-Zeit: $(date)"
else
    echo "❌ Fehler beim Backup zu GitHub"
    exit 1
fi

echo ""
echo "📋 Backup-Status:"
echo "- Lokale Datei: $MEMORIES_FILE"
echo "- GitHub Repository: https://github.com/suma-simic/memories"
echo "- Backup-Zeit: $(date)"
echo ""
echo "🔄 Automatisches Backup alle 7 Tage:"
echo "0 9 * * 0 /Users/markosimic/cyprus-luxury-leads-hub/scripts/backup-memories-to-github.sh" 
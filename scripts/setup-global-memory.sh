#!/bin/bash

# Setup Script für globale Memory-Infrastruktur
# Dieses Script richtet die projektübergreifende Memory-Lösung ein

set -e

echo "🚀 Setup für globale Memory-Infrastruktur..."

# 1. Erstelle globale Memory-Verzeichnisse
echo "📁 Erstelle Memory-Verzeichnisse..."
mkdir -p /Users/markosimic/.cursor/memories
mkdir -p /Users/markosimic/.cursor/memory-backups

# 2. Setze Berechtigungen
echo "🔐 Setze Berechtigungen..."
chmod 755 /Users/markosimic/.cursor/memories
chmod 755 /Users/markosimic/.cursor/memory-backups

# 3. Erstelle initiale Memory-Datei falls nicht vorhanden
if [ ! -f "/Users/markosimic/.cursor/memories/global-memories.jsonl" ]; then
    echo "📝 Erstelle initiale Memory-Datei..."
    touch /Users/markosimic/.cursor/memories/global-memories.jsonl
    chmod 644 /Users/markosimic/.cursor/memories/global-memories.jsonl
fi

# 4. Baue und starte Docker Container
echo "🐳 Baue Memory Graph Server Container..."
docker-compose -f docker-compose.memory.yml build

echo "🚀 Starte Memory Services..."
docker-compose -f docker-compose.memory.yml up -d

# 5. Warte auf Container-Start
echo "⏳ Warte auf Container-Start..."
sleep 10

# 6. Überprüfe Container-Status
echo "🔍 Überprüfe Container-Status..."
docker-compose -f docker-compose.memory.yml ps

# 7. Teste Memory Graph Server
echo "🧪 Teste Memory Graph Server..."
if docker exec global-memory-graph ps aux | grep -q "mcp-knowledge-graph"; then
    echo "✅ Memory Graph Server läuft erfolgreich!"
else
    echo "❌ Fehler beim Starten des Memory Graph Servers"
    exit 1
fi

echo "🎉 Setup abgeschlossen!"
echo ""
echo "📋 Nächste Schritte:"
echo "1. Überprüfe die MCP-Konfiguration in Cursor"
echo "2. Teste Memory-Operationen in einem neuen Workspace"
echo "3. Überprüfe Backups in /Users/markosimic/.cursor/memory-backups"
echo ""
echo "🔧 Nützliche Befehle:"
echo "- Container stoppen: docker-compose -f docker-compose.memory.yml down"
echo "- Logs anzeigen: docker-compose -f docker-compose.memory.yml logs"
echo "- Backup erstellen: docker exec global-memory-graph cp /app/memories/global-memories.jsonl /app/backup/" 
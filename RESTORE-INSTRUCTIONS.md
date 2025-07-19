# Globale Memory-Infrastruktur Wiederherstellung

## Übersicht
Diese Anleitung erklärt, wie du die globale Memory-Infrastruktur nach einem Computer-Ausfall oder -Diebstahl wiederherstellst.

## Voraussetzungen
- Neuer Computer mit macOS
- Docker installiert
- Cursor installiert
- Git installiert

## Schritt-für-Schritt Wiederherstellung

### Schritt 1: GitHub Repository klonen
```bash
git clone https://github.com/suma-simic/memories.git
cd memories
```

### Schritt 2: Docker installieren (falls nicht vorhanden)
```bash
# Docker Desktop für macOS herunterladen und installieren
# https://www.docker.com/products/docker-desktop
```

### Schritt 3: Globale Memory-Infrastruktur wiederherstellen
```bash
# Memory-Datei wiederherstellen
mkdir -p /Users/markosimic/.cursor/memories
cp global-memories.jsonl /Users/markosimic/.cursor/memories/

# Docker-Container starten
docker-compose -f docker-compose.memory.yml up -d

# Setup-Script ausführen
chmod +x scripts/setup-global-memory.sh
./scripts/setup-global-memory.sh
```

### Schritt 4: MCP-Konfiguration wiederherstellen
```bash
# MCP-Konfiguration erstellen
mkdir -p /Users/markosimic/.cursor
cat > /Users/markosimic/.cursor/mcp.json << 'EOF'
{
  "mcpServers": {
    "supabase": {
      "command": "npx",
      "args": ["@supabase/mcp-server-supabase"],
      "env": {
        "SUPABASE_URL": "https://hhziigzlrtomhsumyktv.supabase.co",
        "SUPABASE_ANON_KEY": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhoemlpZ3pscnRvbWhzdW15a3R2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg2Mzg4NjMsImV4cCI6MjA2NDIxNDg2M30.Z-E6KYvZiFQyRRuKAJtsOg2DHwIlcsV7FL-XQKKi6io",
        "SUPABASE_ACCESS_TOKEN": "sbp_eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhoemlpZ3pscnRvbWhzdW15a3R2Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTczNzE5NTI2M30.example"
      }
    },
    "memory": {
      "command": "npx",
      "args": ["@itseasy21/mcp-knowledge-graph"],
      "env": {
        "MEMORY_FILE_PATH": "/Users/markosimic/.cursor/memories/global-memories.jsonl"
      }
    }
  }
}
EOF
```

### Schritt 5: Cursor neu starten
1. Cursor komplett schließen (Cmd+Q)
2. Cursor neu öffnen
3. MCP-Server neu laden: Cmd+Shift+P → "MCP: Reload Servers"

### Schritt 6: Test der Wiederherstellung
```bash
# Container-Status prüfen
docker-compose -f docker-compose.memory.yml ps

# Memory-Datei prüfen
ls -la /Users/markosimic/.cursor/memories/

# Backup-Script testen
./scripts/backup-memories-to-github.sh
```

## Automatisierung

### Vollständige Wiederherstellung mit einem Script:
```bash
chmod +x scripts/restore-global-memory.sh
./scripts/restore-global-memory.sh
```

## Troubleshooting

### Problem: Docker-Container startet nicht
```bash
# Container neu bauen
docker-compose -f docker-compose.memory.yml build --no-cache
docker-compose -f docker-compose.memory.yml up -d
```

### Problem: MCP-Server nicht verfügbar
1. Cursor neu starten
2. Cmd+Shift+P → "MCP: Reload Servers"
3. Cmd+Shift+P → "MCP: List Servers"

### Problem: Memory-Datei nicht gefunden
```bash
# Verzeichnis erstellen
mkdir -p /Users/markosimic/.cursor/memories
# Datei aus GitHub wiederherstellen
cp global-memories.jsonl /Users/markosimic/.cursor/memories/
```

## Wichtige Dateien

- `global-memories.jsonl` - Globale Memory-Datei
- `docker-compose.memory.yml` - Docker-Container-Konfiguration
- `Dockerfile.memory` - Docker-Image-Konfiguration
- `scripts/` - Alle Setup- und Backup-Scripts
- `README-Memory-Setup.md` - Vollständige Dokumentation

## Backup-Status

- **GitHub Repository:** https://github.com/suma-simic/memories
- **Letztes Backup:** $(date)
- **Backup-Frequenz:** Wöchentlich automatisch
- **Wiederherstellungszeit:** ~10 Minuten 
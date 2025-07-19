# Globale Memory-Infrastruktur für Cursor

## Übersicht

Diese Implementierung stellt eine **projektübergreifende Memory-Lösung** für Cursor bereit, die es der KI ermöglicht, von jedem Workspace aus auf alle gespeicherten Memories zuzugreifen.

## Architektur

```
┌─────────────────────────────────────────────────────────────┐
│                    Cursor Workspace                        │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │
│  │   Projekt A │  │   Projekt B │  │   Projekt C │       │
│  └─────────────┘  └─────────────┘  └─────────────┘       │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│              Globale MCP-Konfiguration                     │
│  ┌─────────────────────────────────────────────────────┐   │
│  │         @itseasy21/mcp-knowledge-graph            │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│              Docker Container                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │         Memory Graph Server                        │   │
│  │         + Backup Service                           │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│              Persistente Speicherung                      │
│  ┌─────────────────────────────────────────────────────┐   │
│  │         /Users/markosimic/.cursor/memories/       │   │
│  │         global-memories.jsonl                      │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

## Komponenten

### 1. Docker Container
- **Memory Graph Server**: Läuft den `@itseasy21/mcp-knowledge-graph` Server
- **Backup Service**: Erstellt automatische Backups der Memory-Datei
- **Persistente Volumes**: Speichert Memories außerhalb aller Projekte

### 2. Globale MCP-Konfiguration
- Konfiguriert in `/Users/markosimic/.cursor/mcp.json`
- Verfügbar in allen Cursor Workspaces
- Verbindet sich mit dem Docker Container

### 3. Persistente Speicherung
- **Hauptspeicher**: `/Users/markosimic/.cursor/memories/global-memories.jsonl`
- **Backup-Speicher**: Docker Volume `memory-backup`
- **Automatische Backups**: Stündlich

## Installation

### Schritt 1: Setup ausführen
```bash
./scripts/setup-global-memory.sh
```

### Schritt 2: MCP-Konfiguration überprüfen
Die globale MCP-Konfiguration sollte bereits korrekt sein:
```json
{
  "mcpServers": {
    "memory": {
      "command": "npx",
      "args": ["@itseasy21/mcp-knowledge-graph"],
      "env": {
        "MEMORY_FILE_PATH": "/Users/markosimic/.cursor/memories/global-memories.jsonl"
      }
    }
  }
}
```

### Schritt 3: Testen
1. Öffne einen neuen Cursor Workspace
2. Teste Memory-Operationen:
   - Memory erstellen
   - Memory lesen
   - Memory suchen

## Verwaltung

### Container verwalten
```bash
# Container starten
docker-compose -f docker-compose.memory.yml up -d

# Container stoppen
docker-compose -f docker-compose.memory.yml down

# Logs anzeigen
docker-compose -f docker-compose.memory.yml logs

# Status überprüfen
docker-compose -f docker-compose.memory.yml ps
```

### Backups verwalten
```bash
# Manuelles Backup erstellen
docker exec global-memory-graph cp /app/memories/global-memories.jsonl /app/backup/

# Backups auflisten
docker exec global-memory-graph ls -la /app/backup/
```

### Memory-Datei verwalten
```bash
# Memory-Datei anzeigen
cat /Users/markosimic/.cursor/memories/global-memories.jsonl

# Memory-Datei sichern
cp /Users/markosimic/.cursor/memories/global-memories.jsonl ~/backup/

# Memory-Datei wiederherstellen
cp ~/backup/global-memories.jsonl /Users/markosimic/.cursor/memories/
```

## Vorteile der Lösung

### ✅ Projektübergreifend
- Memories sind in allen Cursor Workspaces verfügbar
- Keine Duplikation von Memory-Daten
- Zentrale Verwaltung

### ✅ Persistente Speicherung
- Docker Volumes für zuverlässige Speicherung
- Automatische Backups
- Keine Datenverluste bei Container-Neustarts

### ✅ Skalierbar
- Einfache Erweiterung um weitere Services
- Monitoring und Logging möglich
- Health Checks integriert

### ✅ Sicher
- Isolierte Container-Umgebung
- Backup-Strategien
- Fehlerbehandlung

## Troubleshooting

### Container startet nicht
```bash
# Logs überprüfen
docker-compose -f docker-compose.memory.yml logs memory-graph-server

# Container neu bauen
docker-compose -f docker-compose.memory.yml build --no-cache
```

### Memory-Datei nicht gefunden
```bash
# Verzeichnis erstellen
mkdir -p /Users/markosimic/.cursor/memories

# Datei erstellen
touch /Users/markosimic/.cursor/memories/global-memories.jsonl

# Berechtigungen setzen
chmod 644 /Users/markosimic/.cursor/memories/global-memories.jsonl
```

### MCP Server nicht verfügbar
1. Überprüfe die MCP-Konfiguration in Cursor
2. Starte Cursor neu
3. Überprüfe Container-Status

## Nächste Schritte

1. **Monitoring hinzufügen**: Prometheus/Grafana für Container-Monitoring
2. **Logging erweitern**: Strukturierte Logs für Memory-Operationen
3. **Synchronisation**: Real-time Sync zwischen mehreren Entwicklern
4. **Versionierung**: Git-basierte Versionierung der Memories
5. **API-Erweiterung**: REST API für externe Tools 
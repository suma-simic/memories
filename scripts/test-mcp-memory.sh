#!/bin/bash

echo "🧪 Teste MCP Memory Server..."

# Teste ob der Memory Server läuft
echo "1. Teste Memory Server Verfügbarkeit..."
if npx @itseasy21/mcp-knowledge-graph --version > /dev/null 2>&1; then
    echo "✅ Memory Server ist verfügbar"
else
    echo "❌ Memory Server ist nicht verfügbar"
    exit 1
fi

# Teste Memory-Datei
echo "2. Teste Memory-Datei..."
if [ -f "/Users/markosimic/.cursor/memories/global-memories.jsonl" ]; then
    echo "✅ Memory-Datei existiert"
    echo "📊 Dateigröße: $(wc -c < /Users/markosimic/.cursor/memories/global-memories.jsonl) Bytes"
    echo "📝 Anzahl Zeilen: $(wc -l < /Users/markosimic/.cursor/memories/global-memories.jsonl)"
else
    echo "❌ Memory-Datei existiert nicht"
    exit 1
fi

# Teste MCP-Konfiguration
echo "3. Teste MCP-Konfiguration..."
if [ -f "/Users/markosimic/.cursor/mcp.json" ]; then
    echo "✅ MCP-Konfiguration existiert"
    if grep -q "global-memory" "/Users/markosimic/.cursor/mcp.json"; then
        echo "✅ global-memory Server ist konfiguriert"
    else
        echo "❌ global-memory Server ist nicht konfiguriert"
    fi
else
    echo "❌ MCP-Konfiguration existiert nicht"
    exit 1
fi

echo ""
echo "🎉 MCP Memory Test abgeschlossen!"
echo ""
echo "📋 Nächste Schritte:"
echo "1. Starte Cursor neu"
echo "2. Öffne ein neues Projekt"
echo "3. Teste: 'Was weißt du über Marko Simic?'" 
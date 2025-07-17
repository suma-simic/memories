# Setup-Checkliste für neue Projekte

## Automatische Setup-Checkliste für neue Projekte

### 1. Projekt- und Zieldefinition klären
- Projektbeschreibung und Anforderungen definieren
- Integrationen planen (Supabase, Resend, Docker, etc.)
- Klare Zielsetzung und Erfolgsmetriken festlegen

### 2. Infrastruktur-Entscheidungen treffen
- **Wo läuft was?** (Cloud, lokal, Docker, Hybrid)
- **Welche Tools werden benötigt?** (Docker, Supabase CLI, Node.js, npm, Vite, etc.)
- **Sonstige Services** (Resend, Stripe, etc.)
- Technologie-Stack und Architektur entscheiden

### 3. Setup-Varianten abwägen
- **Lokal vs. Cloud vs. Docker** bewerten
- **Teamgröße** und **Skalierbarkeit** berücksichtigen
- **Testbarkeit** und **Sicherheit** einplanen
- **Entwicklungsumgebung** optimieren

### 4. Initiales Setup durchführen
- **GitHub-Repo** clonen/pullen
- **Lokale Umgebung** einrichten (Node, npm, ggf. Docker)
- **.env/Secrets/Keys** sicher verwalten
- **Supabase CLI** initialisieren und ggf. mit Cloud-Projekt verknüpfen
- **Lokale Datenbank** (Docker) oder Cloud-DB auswählen und konfigurieren
- **Abhängigkeiten** installieren (npm install)
- **Erste Testläufe** (npm run dev, supabase start, etc.)

### 5. Dokumentation erstellen
- **README** mit Setup-Anweisungen
- **Setup-Guide** für Team-Mitglieder
- **Projektstruktur** dokumentieren
- **Wichtige Befehle** und Workflows festhalten

### 6. Erstes Feature/Modul entwickeln
- **Erstes Feature** erst nach erfolgreichem Setup planen
- **Modulare Entwicklung** beginnen
- **Testing** von Anfang an integrieren

## Automatische Anwendung
Bei jedem neuen Projekt automatisch diese Checkliste durchgehen, bevor mit der eigentlichen Entwicklung begonnen wird.

## Priorität
Diese Checkliste ist essentiell für erfolgreiche Projektstarts und sollte bei jedem neuen Projekt angewendet werden. 
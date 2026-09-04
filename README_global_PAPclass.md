# Setup: Systemweite Einbindung der `PAPclass.cls`

Diese Anleitung beschreibt die Einrichtung der zentralen Dokumentenklasse `PAPclass.cls` im lokalen TeX-System (`TEXMFHOME`). Dadurch steht die Klasse systemweit allen TeX-Compilern sowie VS Code für Autovervollständigung und IntelliSense zur Verfügung.

## Alternative: Lokale Kopie pro Versuchsordner

Solltest du das `TEXMFHOME`-Setup in MiKTeX nicht einrichten wollen, kannst du die `PAPclass.cls` auch direkt in den jeweiligen Versuchsordner kopieren, in dem die `main.tex` liegt.

* **Vorteil:** Funktioniert sofort ohne Einstellungen in MiKTeX oder VS Code. Der Compiler und die Autovervollständigung (IntelliSense) erkennen die Datei direkt im Ordner.
* **Nachteil:** Redundanz. Änderungen an der Dokumentenklasse müssen manuell in alle 30 Versuchsordner kopiert werden.

## Für gemeinsame TeX-Projekte oder Cloud-basiertes Arbeiten:
Hier ist es natürlich scheiße, wenn man eine Änderung an der texfm PAP.cls macht, die aber nicht im git-überwachten Ordner drin ist oder man an zwei Geräten arbeitet (und über OneDrive alles synchronisiert). Für FP-Versuche mit Partner:in ist es dann wsl besser, die PAP.cls einfach auf diesselbe Ebene wie main.tex zu heben.

---

## Warum dieser Schritt notwendig ist

* **Globale Verfügbarkeit:** Die Klasse kann in jedem beliebigen Projektordner ohne relative Pfadangaben (`../../`) genutzt werden.
* **Funktionierender Editor-Support:** VS Code (LaTeX Workshop) erkennt eingebundene Pakete (z. B. `siunitx`) zuverlässig und stellt Autovervollständigungen = IntelliSense wie `\qty`,`\cref`,`\autocite` bereit.
* **Sauberer TeX-Code:** Hilfskonstrukte wie `\input@path` entfallen in den `main.tex`-Dateien komplett.

---

## Schritt-für-Schritt-Anleitung

### 1. `texmf`-Ordner an den richtigen Ort kopieren
Kopiere den vorbereiteten Ordner `texmf` aus `latex_class/` direkt in dein Windows-Benutzerverzeichnis (wenn schon vorhanden, dann den subfolder von `texmf` in vorhanden texmf kopieren):

* **Zielpfad:** `C:\Users\<DeinBenutzername>\texmf\`

Die Ordnerstruktur innerhalb von `texmf` muss exakt wie folgt aufgebaut sein:
`texmf\tex\latex\PAPclass\PAPclass.cls`

### 2. Verzeichnis in MiKTeX registrieren
1. Öffne die **MiKTeX Console** über das Startmenü.
2. Gehe in der linken Menüleiste auf **Settings** und wähle den Reiter **Directories**.
3. Klicke auf das **`+` (Hinzufügen)**-Symbol.
4. Wähle den Ordner `C:\Users\<DeinBenutzername>\texmf` aus.
5. Bestätige mit **Apply** / **OK**.

### 3. Dateidatenbank aktualisieren (FNDB)
1. Gehe in der MiKTeX Console auf **Tasks** (oder unter **Settings** -> **General**).
2. Klicke auf **Refresh file name database (FNDB)**.

### 4. Komfort-Verknüpfung anlegen
Da die tatsächliche Datei `PAPclass.cls` nun im Windows-Benutzerverzeichnis liegt, empfiehlt sich eine Verknüpfung im Projektordner:

1. Navigiere zu `C:\Users\<DeinBenutzername>\texmf\tex\latex\PAPclass\`.
2. Mache einen Rechtsklick auf `PAPclass.cls` und wähle **Verknüpfung erstellen**.
3. Verschiebe die erstellte Verknüpfung in den Ordner `latex_class/` deines Projekts.
4. **Nutzen:** Du kannst die Klassendatei für schnelle Anpassungen direkt aus dem Projekt heraus öffnen, ohne tief in das Benutzerverzeichnis navigieren zu müssen.

---

## Nutzung im Dokument

In allen `main.tex`-Dateien reicht nun der Standardaufruf:

```latex
\documentclass[final,ngerman]{PAPclass}
```
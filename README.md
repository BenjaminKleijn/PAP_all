Kontakt: b.k.ballcr@gmail.com

* Schreibt mir gerne bei Fragen zu Latex, ich hab mir mittlerweile sehr viel angelesen, vielleicht kann ich helfen oder Ressourcen zum nachschauen empfehlen
* Wenn ihr gute Ressourcen findet, um Latex über TeX-Live zu installieren oder irgendwie anders als miktex, dann würde ich mich darüber freuen.
* Falls ihr herausfindet, warum die erste `itemize`-Umgebung als falscher Stil markiert wird und wie man es schafft, dass eine VS Code-TeX-Installation SVGs über Inkscape kompiliert, schreib mir bitte eine Nachricht.
* benutzt siunitx

# Aufbau des PAP Projekts
*benutzt mit Miktex, perl, latex-workshop in VS-Code*

Jeder Versuch hat seinen Ordner mit Subfolder `a_content` für Inhaltsdateien und `images` für Bilder, .pdfs. 
In `main.tex` werden:
* Dateipfade für .bib und images initialisiert
* versuchsspezifischen Daten e.g. Titel, Tutor geändert
* Inhaltsdateien zur pdf zusammengefügt
* koma-style (header,footer) festgelegt

In `tex_files/latex_class`:
* `PAPclass.cls` mit allen packages und globalen einstellungen, ist ganz gut kommentiert. Siehe `README_global_PAPclass `zur korrekten Einbindung  
* in `lit.bib` biblatex entries gesammelt
* in `cmds.tex` custom commands definiert, kann gut sein, dass man dass auch in das `texmf` Verzeichnis legen muss, damit IntelliSense sich die in den Index reinlädt
* in `small_code_templates.tex` finden sich hinweise zum einbinden von pdfs; table, (wrap.,sub-)figure templates

in `tex_files/Auswertung_xxx` ist ein Template für einen PAP-Versuch, zum einfachen kopieren.

in `tex_files/final_submission` sind die fertigen pdf-Dateien (=Altprotokolle)

in `tex_files/knowledge` ist gelerntes Wissen zu LaTeX und python gesammelt, mit vielen Stack_Exchange links zu interessanten Beiträgen

---

# Auswertung & Fehlerrechnung mit Python

In **PAP1** werden viele Diagramme noch per Hand gezeichnet. Ich empfehle jedoch sehr, die Rechnungen in PAP1 direkt in **Python** durchzuführen:

* **Vorteile:** Automatische Fehlerrechnung, korrekte Rundung und Signifikanzentabellen lassen sich schnell und halbautomatisiert erstellen.
* **Vermeidung von Aufwand:** Kein manuelles Rechnen mit dem Taschenrechner, Wolfram Alpha oder Jonis Fehlerrechner *(Nachteile dort: nur Einzelwerte möglich, keine Array-Berechnung, Datenverlust bei Browser-Refresh)*.

In meinem Python-Code `Auswertungen_1/Code/Sigma_Abw.jpynb` sind implementiert:
* Gaußsche Fehlerfortpflanzung
* Signifikanz-Rundung
* $\sigma$-Abweichungen (Sigma-Abweichungen)
* Abweichungstabellen
* in `remove-vocals.jpynb` eine Funktion beim Kopieren aus Altprotokoll-pfds falsch kodierte (die haben kein inputenc und fontenc benutzt) utf8-chars (ä,ö,ü) wieder richtig umzuwandeln

### Empfehlung für erweiterte Fehlerrechnung:
Für automatische Fehlerrechnung und Array-Verrechnung schaut euch das GitHub-Repository von **jmueller209** an. Er hat eine umfassende Python-Bibliothek geschrieben, die deutlich mächtiger als meine kleinen Funktionen ist.

---
# LaTeX Einstellungen/Hinweise/Best Practices
##  USE SIUNITX
## Sprachoptionen (`ngerman`, `english`)

Für die korrekte Sprachübergabe habe ich mehrere Varianten ausprobiert. 

Die Sprache (`1: Nebensprache`, `2: Hauptsprache`) sollte als globale Option in `\documentclass[english,ngerman]{PAPclass}` übergeben werden. Dadurch wird sie an alle Pakete (insbesondere `babel` und `cleveref`) durchgereicht.

> **Wichtiger Hinweis zu Sprachoptionen:**
> * Wird die Sprache nur lokal in den Package-Optionen von `babel` gesetzt, bleiben Referenz-Kürzel von `cleveref` (z. B. *fig.* statt *Abb.*) auf Englisch.
> * Man muss die globale Option an `babel` und `cleveref` übergeben oder sie bei beiden lokal festlegen – lokal ist jedoch kein guter Stil in einer festen `.cls`-Datei, denn alle variablen Einstellungen sollten in der `main.tex` zugänglich sein.
> * **Achtung:** Bei doppelter Festlegung (global `ngerman`, `babel` schon mit `english,ngerman` geladen) gibt `babel` eine Fehlermeldung aus.

## Bilder & Vorlagen in LaTeX

### Einbinden von Bildern
* Nutzt nach Möglichkeit `.jpg`-Dateien $\rightarrow$ geringerer Speicherverbrauch und kleinere PDF-Dateigröße.
* **Tipp zur Komprimierung:** Bei Bedarf kann *ghostscript* installiert werden, um das komprimierte PDF zu verkleinern (siehe `PAP/knowledge/Terminal/Datei_komprimieren.ps1`).

---

## Performance & Kompilierzeiten

In der aktuellen Version dauert das Kompilieren sehr lange. 
### Ursachen:
1. **Schwere Pakete:** `tikz` und `tcolorbox` benötigen viel Rechenzeit. (`tikz` wird selten für Diagramme, sondern meist für Hintergründe/Overlays genutzt; `tcolorbox` dient zur Hervorhebung von Ergebnissen).
2. **Ordnerstruktur:** Eventuell verlangsamt das Navigieren durch verschachtelte Verzeichnisse die Einbindung von Dateien.

### Quick Fix (Kompilierzeit optimieren):
Entferne folgende Zeilen aus der `PAPclass.cls` und auch `\RequirePackage{tcoolorbox}`,etc., wenn nicht benutzt:
```latex
\usepackage{tikz} 
\usepackage{hyperref}  % Muss als letztes Paket geladen werden
\usepackage{cleveref}  % Benötigt hyperref vor der Einbindung
```
und fügt die Zeilen mit auskommentiertem `% tikz` in die main.tex ein, sodass tikz nicht geladen wird.\
Ich verwende tikz nicht zum Erstellen von Diagrammen usw., sondern für backgrounds/overlays sowie margin-bilder (siehe `tikz.tex` in Latex `knowledge`). Wenn man Diagramme baut, dann empfiehlt sich jedoch folgendes:
```latex
\usetikzlibrary{external}
\tikzexternalize % Diagramme werden nur einmal von TikZ verarbeitet/gerendert und anschließend als PDF gespeichert, sodass der nächste Kompilierungsvorgang einfach diese PDF-Datei verwendet
```

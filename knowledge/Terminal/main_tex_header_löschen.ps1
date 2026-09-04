# ==============================================================================
# Skript: Header in allen main.tex-Dateien aktualisieren
# ==============================================================================

# 1. Definiere den neuen Header-Text inklusive der \documentclass-Zeile.
#    Der @" ... "@-Block (Here-String) erlaubt mehrzeiligen Text inklusive Anführungszeichen.
$newHeader = @"
% PAPclass.cls (mit packages) muss übergeben werden: Entweder als globale Datei in ein lokal angelegtes MikTeX-Verzeichnis, oder durch pasten in jeden Versuchsordner zur main.tex (schlecht, da dann 30 mal dieselbe Datei).
% Das Anlegen des globalen Verzeichnisses - siehe README_global_PAPclass.md

% use [draft] for quicker compiling (only loads images as frames and enables showkeys - labels are shown)
% change position to ngerman, english if experiment is done in english
\documentclass[final,english,ngerman]{PAPclass}
"@

# 2. Durchsuche den aktuellen Ordner und alle Unterordner (-Recurse) nach "main.tex".
#    Die Pipeline (|) übergibt jede gefundene Datei an die ForEach-Object-Schleife.
Get-ChildItem -Recurse -Filter "main.tex" | ForEach-Object {

    # Speichere den vollständigen Pfad der aktuellen Datei
    $filePath = $_.FullName

    # Lies den Inhalt der Datei zeilenweise ein (mit UTF-8-Kodierung für Umlaute)
    $lines = Get-Content -Path $filePath -Encoding UTF8

    # Initialisiere die Variable zur Suche des \documentclass-Eintrags.
    # -1 bedeutet: "Noch nicht gefunden".
    $docClassIndex = -1

    # 3. Schleife durch alle Zeilen der Datei, um die Position von \documentclass zu finden
    for ($i = 0; $i -lt $lines.Count; $i++) {
        # Regulärer Ausdruck prüft, ob die Zeile den Befehl '\documentclass' enthält
        if ($lines[$i] -match '\\documentclass') {
            $docClassIndex = $i  # Speichere den Zeilen-Index (0-basiert)
            break                # Brich die Suche ab, da der erste Treffer reicht
        }
    }

    # 4. Prüfe, ob \documentclass in der Datei existiert
    if ($docClassIndex -ne -1) {

        # Schneide die alten Zeilen ab: Behalte nur die Zeilen STRENG NACH \documentclass
        # Array-Slicing von ($docClassIndex + 1) bis zum Ende der Datei
        $remainingLines = $lines[($docClassIndex + 1)..($lines.Count - 1)]

        # Füge den neuen Header, zwei Zeilenumbrüche (`r`n`r`n) für einen leeren Absatz
        # und den verbliebenen Originaltext (wieder zusammengesetzt) zusammen.
        $newContent = $newHeader + "`r`n`r`n" + ($remainingLines -join "`r`n")

        # Schreibe den neuen Gesamtinhalt zurück in die Datei (UTF-8)
        Set-Content -Path $filePath -Value $newContent -Encoding UTF8

        # Erfolgsmeldung in grün ausgeben
        Write-Host "Aktualisiert: $filePath" -ForegroundColor Green

    } else {
        # Warnmeldung in gelb ausgeben, falls die Zeile gefehlt hat
        Write-Host "'\documentclass' nicht gefunden in: $filePath" -ForegroundColor Yellow
    }
}
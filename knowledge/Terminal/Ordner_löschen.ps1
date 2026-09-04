# open folder in VS Code and press strg+ö to open a terminal
# select PowerShell

# Find items in opened folder and its subdirectories
Get-ChildItem -Recurse -Filter "dateiname.endung" 

# Remove items 
Get-ChildItem -Recurse -Filter "dateiname.endung" | Remove-Item

# Remove items - WhatIf Test:
Get-ChildItem -Recurse -Filter "dateiname.endung" | Remove-Item -WhatIf

# Remove items - name-match
Get-ChildItem -Filter *.pdf -Recurse | Where-Object { $_.Name -notlike "*_compact.pdf" } | Remove-Item -WhatIf

# delete folders - WhatIf
Get-ChildItem -Recurse -Directory -Filter "Ordnername" | Remove-Item -Recurse -WhatIf       # -Recurse deletes the files inside the subfolders
# Delete folders
Get-ChildItem -Recurse -Directory -Filter "Ordnername" | Remove-Item -Recurse -Force        # -Force löscht auch schreibgeschützte Dinge 
# Wenn Ordnername = ".Ordnername" dann braucht man das keyword -Hidden
Get-ChildItem -Recurse -Hidden -Directory -Filter ".git"


# select specific folders, e.g. also in einem Verzeichnis alle Ordner, die diesen Namen haben
Get-ChildItem -Recurse -Directory -Filter "*Versuch*"
# create file in each found folder 
Get-ChildItem -Recurse -Directory -Filter "*Versuch*" | ForEach-Object { New-Item -Path $_.FullName -Name "note.txt" -ItemType "File" }     # -Value "% Dokumentation`n\section{Notizen}" als weiteres Keyword nach -File, schreibt diesen Text als Inhalt rein

# Move file in one central folder
Get-ChildItem -Recurse -Filter "ergebnis.pdf" | Move-Item -Destination "C:\ZentralerOrdner" -WhatIf
# Move file from one subfolder into another subfolder and that for multiple folders
Get-ChildItem -Directory -Filter "*_*" | ForEach-Object {      # WIldcard (weak search machine) search string: for foldernames that have "_" somewhere; regex searches with Where-Object
    $quelle = Join-Path $_.FullName "include\titlepage.tex"
    $ziel   = Join-Path $_.FullName "a_content"

    if (Test-Path $quelle) {
        # Falls der Zielordner "a_content" noch nicht existiert, wird er automatisch erstellt
        if (-not (Test-Path $ziel)) {
            New-Item -ItemType Directory -Path $ziel | Out-Null
        }
        
        # Verschiebt die Datei nach a_content
        Move-Item -Path $quelle -Destination $ziel -WhatIf # -Force wenn Test vorbei
    }
}

# Test
Get-ChildItem -Directory | Where-Object { $_.Name -match '^\d+$' } | ForEach-Object {
    $quelle = Join-Path $_.FullName "include\titlepage.tex"
    $ziel   = Join-Path $_.FullName "a_content"

    if (Test-Path $quelle) {
        Move-Item -Path $quelle -Destination $ziel -WhatIf
    }
}

# Move folder
Get-ChildItem -Directory | Where-Object { $_.Name -match '^\d+$' } | ForEach-Object {       # Where-Object erlaubt genauere searches mit regex, oben können schnell Fehler entstehen, mit allgemeinen Ausdrücken wie "*_*" 
    $imagesFolder = Join-Path $_.FullName "include\images"

    if (Test-Path $imagesFolder) {
        Move-Item -Path $imagesFolder -Destination $_.FullName -Force
    }
}
# danach leeren include folder löschen
Get-ChildItem -Directory | Where-Object { $_.Name -match '^\d+$' } | ForEach-Object {
    $includeFolder = Join-Path $_.FullName "include"

    if (Test-Path $includeFolder) {
        Remove-Item -Path $includeFolder -Recurse -Force
    }
}


Get-ChildItem -Recurse -Filter "main.pdf"| ForEach-Object {

    $quelle =  $_.FullName 

    $ziel   =  $_."C:\Users\samue\Documents\PAP\final_submission"
    
    -Name = basename

    if (Test-Path $quelle and $_.Name - match '_1') {
    $ziel = Join-Path $_. "PAP1"
    }
    if (Test-Path $quelle and $_.Name - match '_2.1') {
    $ziel = Join-Path $_. "PAP2.1"
    }
    if (Test-Path $quelle and $_.Name - match '_2.2') {
    $ziel = Join-Path $_. "PAP2.2"
    }
    Move-Item -Path $quelle -Destination $ziel -WhatIf
} 


## Alle main.pdf Dateien richtig sortiert in final_submission reinladen
$basisZiel = "C:\Users\samue\Documents\PAP\final_submission"

Get-ChildItem -Recurse -Filter "main.pdf" | ForEach-Object {
    $quelle             = $_.FullName
    $ordnerName         = $_.Directory.Name          # z. B. "Versuch_1"
    $grossElternOrdner  = $_.Directory.Parent.Name   # z. B. "Auswertungen_1"
    
    # Abfrage auf den Namen des Eltern-Eltern-Ordners
    if ($grossElternOrdner -match '_2\.1') {
        $zielUnterordner = Join-Path $basisZiel "PAP2.1"
    }
    elseif ($grossElternOrdner -match '_2\.2') {
        $zielUnterordner = Join-Path $basisZiel "PAP2.2"
    }
    elseif ($grossElternOrdner -match '_1') {
        $zielUnterordner = Join-Path $basisZiel "PAP1"
    }
    else {
        $zielUnterordner = $basisZiel
    }

    # Zielordner erstellen, falls nicht vorhanden
    if (-not (Test-Path $zielUnterordner)) {
        New-Item -ItemType Directory -Path $zielUnterordner -Force | Out-Null
    }

    # Datei kopieren und nach dem direkten Ordner benennen (z. B. Versuch_1.pdf)
    $zielDatei = Join-Path $zielUnterordner "$ordnerName.pdf"
    Copy-Item -Path $quelle -Destination $zielDatei -WhatIf
}
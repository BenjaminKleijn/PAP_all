# mit ghostscript (herunterladen)
# dann in VS Code im ordner der befindlichen Datei powershell öffnen
# WICHTIG: cmd schreiben und dann diesen Befehl pasten
gswin64c -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=main_klein.pdf Auswertung_TeX/main.pdf

# /prepress behält intern eingebundene pdfs in guter Qualität (ebook hat die gelöscht)
# /ebook = Mittlere Qualität (~150 dpi, ideal für digitale Nutzung).
# /screen = Niedrige Qualität (~72 dpi, sehr kleine Datei).
# /printer = Hohe Qualität (~300 dpi).


# alle dateien im folder komprimieren
Get-ChildItem -Filter *.pdf -Recurse | Where-Object { $_.Name -notlike "*_compact.pdf" } | ForEach-Object {
    $out = Join-Path $_.DirectoryName "$($_.BaseName)_compact.pdf"
    $args = @(
        "-sDEVICE=pdfwrite",
        "-dCompatibilityLevel=1.4",
        "-dPDFSETTINGS=/prepress",
        "-dNOPAUSE",
        "-dQUIET",
        "-dBATCH",
        "-sOutputFile=$out",
        $_.FullName
    )
    & gswin64c $args
}
gswin64c "-sDEVICE=pdfwrite" "-dCompatibilityLevel=1.4",
        "-dPDFSETTINGS=/prepress",
        "-dNOPAUSE",
        "-dQUIET",
        "-dBATCH",
        "-sOutputFile=$out",
# und danach alle unkomprimierten löschen
Get-ChildItem -Filter *.pdf -Recurse | Where-Object { $_.Name -notlike "*_compact.pdf" } | Remove-Item -WhatIf
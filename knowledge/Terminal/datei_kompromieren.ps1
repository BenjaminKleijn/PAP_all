# mit ghostscript (herunterladen)
# dann in VS Code im ordner der befindlichen Datei powershell öffnen
# cmd schreiben und dann diesen Befehl pasten
gswin64c -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress -dNOPAUSE -dQUIET -dBATCH -sOutputFile=main_klein.pdf Auswertung_TeX/main.pdf

# /prepress behält intern eingebundene pdfs in guter Qualität (ebook hat die gelöscht)
# /ebook = Mittlere Qualität (~150 dpi, ideal für digitale Nutzung).
# /screen = Niedrige Qualität (~72 dpi, sehr kleine Datei).
# /printer = Hohe Qualität (~300 dpi).
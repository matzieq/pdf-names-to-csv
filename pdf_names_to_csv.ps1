$fileName = ".\projekty.csv"

# Stworzenie/wyczyszczenie pliku
Out-File -FilePath $fileName

# Iteracja po wszystkich podkatalogach rekurencyjnie
Get-ChildItem -Path "." -Directory -Recurse | ForEach-Object {
    # Tablica z nazwami wszystkich PDFów w danym podkatalogu
    $pdfs = (Get-ChildItem -Path $_.FullName *.pdf).Basename

    # Jak nie jest pusta
    if ($pdfs) {
        # Dodaj do csv nazwę danego podkatalogu
        $_.FullName | Out-File -Append -FilePath $fileName

        # Dla każdej nazwy pdfa - zastąp podkreślniki przecinkami, po przecinku doklej pełną nazwę na wszelki wypadek,
        # całość dopisz do csv
        ForEach ($pdf in $pdfs) {
            "$($pdf -split "_" -join ","),$($pdf)" | Out-File -Append -FilePath $fileName
        }
    }
}
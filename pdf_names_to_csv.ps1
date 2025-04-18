$fileName = ".\projekty.csv"
$regex = "007 - Leon|20220422_Archive"

# Stworzenie/wyczyszczenie pliku
Out-File -FilePath $fileName

# Iteracja po wszystkich podkatalogach rekurencyjnie, z wyłączeniem tych pasujących do regexu
Get-ChildItem -Path "." -Directory -Recurse | Where-Object { $_.FullName -cnotmatch $regex } | ForEach-Object {
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
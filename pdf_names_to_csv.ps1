Get-ChildItem -Path "." -Directory -Recurse | ForEach-Object {
    $pdfs = (Get-ChildItem -Path $_.FullName *.pdf).Basename

    if ($pdfs) {
        $fileName = "$($_.FullName)\$($_.Name).csv"
        Out-File -FilePath $fileName
    
        ForEach ($pdf in $pdfs) {
            "$($pdf -split "_" -join ","),$($pdf)" | Out-File -Append -FilePath $fileName
        }
    }
}
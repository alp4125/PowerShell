
$PNum = "Fredrik 666666-6666 Nisse" | Select-String "((\d)(\d)(\d)(\d)(\d)(\d)-(\d)(\d)(\d)(\d))" | ForEach-Object { $_.Matches[0].Groups[0].Value }

if (!($Pnum)) {
    "Inte personnummer"
} else {
    "Personnummer"
}

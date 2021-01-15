Add-Type -Assembly PresentationCore

If([System.Windows.Clipboard]::ContainsText())
{
    [System.Windows.Clipboard]::GetText()
}
ElseIf([System.Windows.Clipboard]::ContainsImage())
{
    [System.Windows.Clipboard]::GetImage()
}
ElseIf([System.Windows.Clipboard]::ContainsFileDropList())
{
    [System.Windows.Clipboard]::GetFileDropList()
}

[System.Windows.Clipboard]::Clear()
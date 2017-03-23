'=================================================================
' %1              : Search target file
' %2              : Search string
' %SEARCH_RESULT% : Search result (return value)
Option Explicit

Const ForReading = 1
Const ForWriting = 2

Dim objFso
Dim objFile

Dim strTemp
Dim strResult

Set objFso = CreateObject("Scripting.FileSystemObject") 
Set objFile = objFso.OpenTextFile(WScript.Arguments(0), ForReading) 

strResult=""
Do Until objFile.AtEndOfStream 
    strTemp = objFile.ReadLine
    If InStr(strTemp, WScript.Arguments(1)) <> 0 Then
        strResult=strTemp
    End If
Loop 
objFile.Close 
Set objFile = Nothing

Wscript.echo Replace(strResult, vbTab, " ")
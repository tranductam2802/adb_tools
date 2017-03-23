'=================================================================
' %1 : Text file to eliminate multiple line breaks

Option Explicit

Const ForReading = 1
Const ForWriting = 2

Dim objFso
Dim objFile
Dim objStream
Dim objReadFile
Dim objWriteFile

Dim strFileName
Dim strFileNamePath
DIm strTempFileName
DIm strTempFileNamePath
Dim strData


Set objFso = CreateObject("Scripting.FileSystemObject")

If WScript.Arguments.Count = 0 Then
    msgbox "Could not find the file location in arguments list", vbCritical, Wscript.ScriptName
    WScript.Quit
End If


strFileNamePath = WScript.Arguments(0)
strFileName = objFso.getFileName(strFileNamePath)
strTempFileName = "a" & strFileName
strTempFileNamePath = objFso.GetParentFolderName(strFileNamePath) & "\\" & StrTempFileName


Set objStream = CreateObject("ADODB.Stream")

objStream.Type = 2
objStream.Charset = "UTF-8"
objStream.Open
objStream.LoadFromFile strFileNamePath

strData = objStream.ReadText(-1)

objStream.close
Set objStream = Nothing


strData = Replace(strData, vbCrLf, "")
strData = Replace(strData, vbCr, vbCrLf)


Set objStream = CreateObject("ADODB.Stream")

objStream.Type = 2
objStream.Charset = "UTF-8"
objStream.Open


objStream.WriteText strData, 0
objStream.SaveToFile strTempFileNamePath, 2

objStream.close
Set objStream = Nothing


DeleteFile strFileNamePath

Set objFile = objFso.GetFile(strTempFileNamePath)
objFile.Name = strFileName
Set objFile = Nothing

WScript.Quit

Sub DeleteFile(deleteFileNamePath)
    Do While objFso.FileExists(deleteFileNamePath)
        objFso.DeleteFile deleteFileNamePath, True
        WScript.Sleep(100)
    Loop
End Sub
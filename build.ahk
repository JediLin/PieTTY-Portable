#SingleInstance
VerNo = %A_YYYY%.%A_MM%.%A_DD%.%A_Hour%.%A_Min%
ThisVer = %A_YYYY%%A_MM%%A_DD%%A_Hour%%A_Min%
WinRARFullPath = c:\Program Files\WinRAR\WinRAR.exe

IfExist, ThisVer.ahk
{
  FileSetAttrib, -RHS, ThisVer.ahk
  FileDelete, ThisVer.ahk
}
FileAppend, ThisVer = %ThisVer%, ThisVer.ahk
IfExist, PieTTYPortable.exe
{
  FileSetAttrib, -RHS, PieTTYPortable.exe
  FileDelete, PieTTYPortable.exe
}
RunWait, ..\Ahk2Exe\Ahk2Exe.exe /in ..\PieTTYPortable\piettyportable.ahk /out ..\PieTTYPortable\PieTTYPortable.exe /icon ..\PieTTYPortable\pietty.ico
FileSetAttrib, -RHS, *.exe
FileSetAttrib, -RHS, *.ico
FileSetAttrib, -RHS, *.ini
IniRead, PiettyExec, piettyportable.ini, FileName, PieTTY
RunWait, %WinRARFullPath% a -afrar -av -ep1 -k -m5 -md4096 -r -rr10p -s -t -tk -zpiettyportable.diz Release\PieTTYPortableFull-%VerNo%.rar pietty.ico %PiettyExec% PieTTYPortable.exe piettyportable.ini
RunWait, %WinRARFullPath% a -afrar -av -ep1 -k -m5 -md4096 -r -rr10p -s -t -tk -zpiettyportable.diz Release\PieTTYPortable-%VerNo%.rar pietty.ico PieTTYPortable.exe piettyportable.ini
MsgBox, 36, Overwrite?, Overwrite ver.txt to push Major Version Update?
IfMsgBox, Yes
{
  FileSetAttrib, -RHS, ver.txt
  FileDelete, ver.txt
  FileAppend, %ThisVer%, ver.txt
}
ExitApp

#SingleInstance ignore
#MaxThreadsPerHotkey 20
#include locale.ahk
#include ThisVer.ahk
WinHotkeyAvailableList = 0,G,H,J,N,O,Q,T,W,X,Y,Z
Menu, Tray, Tip, %TooltipTray%
Menu, Tray, Icon, pietty.ico, 1, 1
Menu, Tray, NoStandard
IniRead, ReadOnlyIni, piettyportable.ini, Settings, ReadOnly, 0
If (ReadOnlyIni != 1 and ReadOnlyIni != 0) {
  ReadOnlyIni = 0
  FileSetAttrib, -RHS, piettyportable.ini
  IniWrite, %ReadOnlyIni%, piettyportable.ini, Settings, ReadOnly
}
ReadOnlySession = %ReadOnlyIni%
IfExist, test.file.tmp
{
  FileSetAttrib, -RHS, test.file.tmp
  FileDelete, test.file.tmp
}
FileAppend, test writing, test.file.tmp
IfExist, test.file.tmp
{
  FileSetAttrib, -RHS, test.file.tmp
  FileDelete, test.file.tmp
}
FileWritingProblem := ErrorLevel
If (FileWritingProblem = 1) {
  ReadOnlySession = 1
}
StorageRootPath =
If (ReadOnlySession = 1) {
  StorageRootPath = %A_Temp%\
  FileCopy, piettyportable.ini, %StorageRootPath%piettyportable.ini, 1
}
Init:
IniRead, PiettyExec, %StorageRootPath%piettyportable.ini, FileName, PieTTY
IfNotExist, %PiettyExec%
{
  PiettyExec =
}
If (PiettyExec = "ERROR" or PiettyExec = "") {
  FileSelectFile, PiettyExecFull, 1, , %TitleAskPiettyExec%, %FiletypeAskPiettyExec% (*.exe)
  If PiettyExecFull =
  {
    ExitApp
  }
  SplitPath, PiettyExecFull, PiettyExec
  FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
  IniWrite, %PiettyExec%, %StorageRootPath%piettyportable.ini, FileName, PieTTY
  Goto, Init
}
Menu, Tray, Add, %NewConnectionItemMenuTray%, IsRunning
Menu, SetNewWindowHotkey, Add, %SetNewWindowHotkeyNone%, SetNewWindowHotkey0
Menu, SetNewWindowHotkey, Add, Win+G, SetNewWindowHotkeyG
Menu, SetNewWindowHotkey, Add, Win+H, SetNewWindowHotkeyH
Menu, SetNewWindowHotkey, Add, Win+J, SetNewWindowHotkeyJ
Menu, SetNewWindowHotkey, Add, Win+N, SetNewWindowHotkeyN
Menu, SetNewWindowHotkey, Add, Win+O, SetNewWindowHotkeyO
Menu, SetNewWindowHotkey, Add, Win+Q, SetNewWindowHotkeyQ
Menu, SetNewWindowHotkey, Add, Win+T, SetNewWindowHotkeyT
Menu, SetNewWindowHotkey, Add, Win+W, SetNewWindowHotkeyW
Menu, SetNewWindowHotkey, Add, Win+X, SetNewWindowHotkeyX
Menu, SetNewWindowHotkey, Add, Win+Y, SetNewWindowHotkeyY
Menu, SetNewWindowHotkey, Add, Win+Z, SetNewWindowHotkeyZ
Menu, Tray, Add, %SetNewWindowHotkeyItemMenuTray%, :SetNewWindowHotkey
Menu, SetMaxBackup, Add, 0, SetMaxBackup0
Menu, SetMaxBackup, Add, 1, SetMaxBackup1
Menu, SetMaxBackup, Add, 2, SetMaxBackup2
Menu, SetMaxBackup, Add, 3, SetMaxBackup3
Menu, SetMaxBackup, Add, 4, SetMaxBackup4
Menu, SetMaxBackup, Add, 5, SetMaxBackup5
Menu, Tray, Add
Menu, Tray, Add, %SetMaxBackupItemMenuTray%, :SetMaxBackup
Menu, Tray, Add, %EnableReadOnlyItemMenuTray%, EnableReadOnly
Menu, Tray, Add, %ToggleNativePieTTYPortableModeItemMenuTray%, ToggleNativePieTTYPortableMode
Menu, Tray, Add
Menu, Tray, Add, %ToggleCheckNewVersionPeriodicallyItemMenuTray%, ToggleCheckNewVersionPeriodically
Menu, Tray, Add, %CheckNewVersionItemMenuTray%, CheckNewVersion
Menu, Tray, Add
Menu, Tray, Add, %AboutItemMenuTray%, About
Menu, Tray, Default, %NewConnectionItemMenuTray%
Menu, Tray, Click, 1
IniRead, PiettyReg, %StorageRootPath%piettyportable.ini, FileName, Registry, piettyportable.reg
If (ReadOnlySession = 1) {
  FileCopy, %PiettyReg%, %StorageRootPath%%PiettyReg%, 1
}
IniRead, TempReg, %StorageRootPath%piettyportable.ini, FileName, Temp, temp.reg
IniRead, NewWindowHotkey, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey, 0
If NewWindowHotkey not in %WinHotkeyAvailableList%
{
  NewWindowHotkey = 0
}
Hotkey, #G, Off
Hotkey, #H, Off
Hotkey, #J, Off
Hotkey, #N, Off
Hotkey, #O, Off
Hotkey, #Q, Off
Hotkey, #T, Off
Hotkey, #W, Off
Hotkey, #X, Off
Hotkey, #Y, Off
Hotkey, #Z, Off
If (NewWindowHotkey = 0) {
  Menu, SetNewWindowHotkey, Check, %SetNewWindowHotkeyNone%
} else {
  Menu, SetNewWindowHotkey, Check, Win+%NewWindowHotkey%
  Hotkey, #%NewWindowHotkey%, On
}
IniRead, MaxBackup, %StorageRootPath%piettyportable.ini, Settings, MaxBackup, 3
If MaxBackup is not integer
{
  MaxBackup = 3
  FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
  IniWrite, %MaxBackup%, %StorageRootPath%piettyportable.ini, Settings, MaxBackup
}
If (ReadOnlySession = 1) {
  MaxBackup = 0
  Menu, SetMaxBackup, Disable, 1
  Menu, SetMaxBackup, Disable, 2
  Menu, SetMaxBackup, Disable, 3
  Menu, SetMaxBackup, Disable, 4
  Menu, SetMaxBackup, Disable, 5
  Menu, Tray, Disable, %SetMaxBackupItemMenuTray%
  Menu, Tray, Check, %EnableReadOnlyItemMenuTray%
  Menu, Tray, Disable, %EnableReadOnlyItemMenuTray%
  Menu, Tray, Disable, %ToggleNativePieTTYPortableModeItemMenuTray%
  Menu, Tray, Disable, %ToggleCheckNewVersionPeriodicallyItemMenuTray%
}
If MaxBackup between 0 and 5
{
  Menu, SetMaxBackup, Check, %MaxBackup%
}
IniRead, NativePieTTYPortableMode, %StorageRootPath%piettyportable.ini, Settings, NativePieTTYPortableMode, 1
NativePieTTYPortableModeSession = 0
If (NativePieTTYPortableMode = 1) {
  Menu, Tray, Check, %ToggleNativePieTTYPortableModeItemMenuTray%
  IfExist, PieTTY.ini
  {
    NativePieTTYPortableModeSession = 1
    Menu, SetMaxBackup, Disable, 1
    Menu, SetMaxBackup, Disable, 2
    Menu, SetMaxBackup, Disable, 3
    Menu, SetMaxBackup, Disable, 4
    Menu, SetMaxBackup, Disable, 5
    Menu, Tray, Disable, %SetMaxBackupItemMenuTray%
  }
}
IniRead, CheckNewVersionPeriodically, %StorageRootPath%piettyportable.ini, Settings, CheckNewVersionPeriodically, 1
If (CheckNewVersionPeriodically = 1) {
  Menu, Tray, Check, %ToggleCheckNewVersionPeriodicallyItemMenuTray%
}
IniRead, Running, %StorageRootPath%piettyportable.ini, Status, Running, 0
If (Running = 1) {
  Goto, IsRunning
}
If (NativePieTTYPortableModeSession != 1) {
  IfNotExist, %WinDir%\regedit.exe
  {
    MsgBox, 16, %TitleError%, %MsgCanNotFindRegEdit%, 10
    ExitApp
  }
  IfExist, %StorageRootPath%%TempReg%
  {
    FileSetAttrib, -RHS, %StorageRootPath%%TempReg%
    FileDelete, %StorageRootPath%%TempReg%
  }
  RunWait, %WinDir%\regedit.exe /E %StorageRootPath%%TempReg% "HKEY_CURRENT_USER\Software\SimonTatham"
  RegDelete, HKCU, Software\SimonTatham
  IfNotExist, %StorageRootPath%%PiettyReg%
  {
    IfExist, %StorageRootPath%%TempReg%
    {
      MsgBox, 35, %TitleAskCopyReg%, %MsgAskCopyReg%
      IfMsgBox Yes
      {
        FileCopy, %StorageRootPath%%TempReg%, %StorageRootPath%%PiettyReg%, 1
      }
      else IfMsgBox Cancel
      {
        RunWait, %WinDir%\regedit.exe /S %StorageRootPath%%TempReg%
        FileSetAttrib, -RHS, %StorageRootPath%%TempReg%
        FileDelete, %StorageRootPath%%TempReg%
        ExitApp
      }
    }
  }
  IfExist, %StorageRootPath%%PiettyReg%
  {
    RunWait, %WinDir%\regedit.exe /S %StorageRootPath%%PiettyReg%
  }
}
If (CheckNewVersionPeriodically = 1) {
  IniRead, LastCheck, %StorageRootPath%piettyportable.ini, Status, LastCheck, %ThisVer%
  If LastCheck is not integer
  {
    LastCheck = %ThisVer%
  }
  CurrentTimestamp = %A_YYYY%%A_MM%%A_DD%%A_Hour%%A_Min%
  CheckLatency := CurrentTimestamp - LastCheck
  If (CheckLatency > 70000) {
    FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
    IniWrite, %CurrentTimestamp%, %StorageRootPath%piettyportable.ini, Status, LastCheck
    UrlDownloadToFile, %ProjectHome%ver.txt, %StorageRootPath%ver.txt
    FileReadLine, RecentVer, %StorageRootPath%ver.txt, 1
    FileSetAttrib, -RHS, %StorageRootPath%ver.txt
    FileDelete, %StorageRootPath%ver.txt
    If RecentVer is integer
    {
      If (RecentVer > ThisVer) {
        MsgBox, 64, %TitleNewVerAvailable%, %MsgNewVerAvailable%
      }
    }
  }
}
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, 1, %StorageRootPath%piettyportable.ini, Status, Running
IsRunning:
RunWait, %PiettyExec%
Process, Exist, %PiettyExec%
Running := ErrorLevel
If (Running = 0) {
  FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
  IniWrite, 0, %StorageRootPath%piettyportable.ini, Status, Running
  If (NativePieTTYPortableModeSession != 1) {
    If (MaxBackup > 0) {
      BackupCount := MaxBackup
      Loop, %MaxBackup%
      {
        BackupCountPre := BackupCount -1
        IfExist, %StorageRootPath%%PiettyReg%.%BackupCount%
        {
          FileSetAttrib, -RHS, %StorageRootPath%%PiettyReg%.%BackupCount%
        }
        If (BackupCount > 1) {
          FileCopy, %StorageRootPath%%PiettyReg%.%BackupCountPre%, %StorageRootPath%%PiettyReg%.%BackupCount%, 1
        }
        If (BackupCount = 1) {
          FileCopy, %StorageRootPath%%PiettyReg%, %StorageRootPath%%PiettyReg%.%BackupCount%, 1
        }
        BackupCount := BackupCount -1
      }
    }
    FileSetAttrib, -RHS, %StorageRootPath%%PiettyReg%
    RunWait, %WinDir%\regedit.exe /E %StorageRootPath%%PiettyReg% "HKEY_CURRENT_USER\Software\SimonTatham"
    RegDelete, HKCU, Software\SimonTatham
    RunWait, %WinDir%\regedit.exe /S %StorageRootPath%%TempReg%
    FileSetAttrib, -RHS, %StorageRootPath%%TempReg%
    FileDelete, %StorageRootPath%%TempReg%
  }
  If (ReadOnlySession = 1 and StorageRootPath != "") {
    FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
    FileDelete, %StorageRootPath%piettyportable.ini
    FileSetAttrib, -RHS, %StorageRootPath%%PiettyReg%
    FileDelete, %StorageRootPath%%PiettyReg%
  }
  ExitApp
}
return

About:
MsgBox, 64, %AboutItemMenuTray%, %MsgAbout%`n`n`n`n%Copyright%`n`n%License%`n%LicenseURL%`n
return

CheckNewVersion:
CurrentTimestamp = %A_YYYY%%A_MM%%A_DD%%A_Hour%%A_Min%
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, %CurrentTimestamp%, %StorageRootPath%piettyportable.ini, Status, LastCheck
UrlDownloadToFile, %ProjectHome%ver.txt, %StorageRootPath%ver.txt
FileReadLine, RecentVer, %StorageRootPath%ver.txt, 1
FileSetAttrib, -RHS, %StorageRootPath%ver.txt
FileDelete, %StorageRootPath%ver.txt
If RecentVer is not integer
{
  MsgBox, 16, %TitleError%, %MsgVerFileWrong%
} else {
  If (RecentVer > ThisVer) {
    MsgBox, 64, %TitleNewVerAvailable%, %MsgNewVerAvailable%
  } else {
    MsgBox, 64, %TitleNoNewVer%, %MsgNoNewVer%
  }
}
return

ToggleCheckNewVersionPeriodically:
Menu, Tray, ToggleCheck, %ToggleCheckNewVersionPeriodicallyItemMenuTray%
CheckNewVersionPeriodically := (CheckNewVersionPeriodically - 1)**2
IniWrite, %CheckNewVersionPeriodically%, %StorageRootPath%piettyportable.ini, Settings, CheckNewVersionPeriodically
return

ToggleNativePieTTYPortableMode:
Menu, Tray, ToggleCheck, %ToggleNativePieTTYPortableModeItemMenuTray%
NativePieTTYPortableMode := (NativePieTTYPortableMode - 1)**2
IniWrite, %NativePieTTYPortableMode%, %StorageRootPath%piettyportable.ini, Settings, NativePieTTYPortableMode
return

EnableReadOnly:
MaxBackup = 0
NativePieTTYPortableMode = 1
CheckNewVersionPeriodically = 0
Menu, Tray, Check, %EnableReadOnlyItemMenuTray%
Menu, Tray, Disable, %EnableReadOnlyItemMenuTray%
Menu, Tray, Check, %ToggleNativePieTTYPortableModeItemMenuTray%
Menu, Tray, Uncheck, %ToggleCheckNewVersionPeriodicallyItemMenuTray%
Menu, Tray, Disable, %ToggleCheckNewVersionPeriodicallyItemMenuTray%
Menu, SetMaxBackup, Check, 0
Menu, SetMaxBackup, Uncheck, 1
Menu, SetMaxBackup, Uncheck, 2
Menu, SetMaxBackup, Uncheck, 3
Menu, SetMaxBackup, Uncheck, 4
Menu, SetMaxBackup, Uncheck, 5
Menu, SetMaxBackup, Disable, 1
Menu, SetMaxBackup, Disable, 2
Menu, SetMaxBackup, Disable, 3
Menu, SetMaxBackup, Disable, 4
Menu, SetMaxBackup, Disable, 5
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, 0, %StorageRootPath%piettyportable.ini, Settings, MaxBackup
IniWrite, 1, %StorageRootPath%piettyportable.ini, Settings, ReadOnly
IniWrite, 1, %StorageRootPath%piettyportable.ini, Settings, NativePieTTYPortableMode
IniWrite, 0, %StorageRootPath%piettyportable.ini, Settings, CheckNewVersionPeriodically
MsgBox, 64, %EnableReadOnlyItemMenuTray%, %MsgReadOnly%
return

SetMaxBackup0:
MaxBackup = 0
Menu, SetMaxBackup, Check, 0
Menu, SetMaxBackup, Uncheck, 1
Menu, SetMaxBackup, Uncheck, 2
Menu, SetMaxBackup, Uncheck, 3
Menu, SetMaxBackup, Uncheck, 4
Menu, SetMaxBackup, Uncheck, 5
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, 0, %StorageRootPath%piettyportable.ini, Settings, MaxBackup
return

SetMaxBackup1:
MaxBackup = 1
Menu, SetMaxBackup, Uncheck, 0
Menu, SetMaxBackup, Check, 1
Menu, SetMaxBackup, Uncheck, 2
Menu, SetMaxBackup, Uncheck, 3
Menu, SetMaxBackup, Uncheck, 4
Menu, SetMaxBackup, Uncheck, 5
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, 1, %StorageRootPath%piettyportable.ini, Settings, MaxBackup
return

SetMaxBackup2:
MaxBackup = 2
Menu, SetMaxBackup, Uncheck, 0
Menu, SetMaxBackup, Uncheck, 1
Menu, SetMaxBackup, Check, 2
Menu, SetMaxBackup, Uncheck, 3
Menu, SetMaxBackup, Uncheck, 4
Menu, SetMaxBackup, Uncheck, 5
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, 2, %StorageRootPath%piettyportable.ini, Settings, MaxBackup
return

SetMaxBackup3:
MaxBackup = 3
Menu, SetMaxBackup, Uncheck, 0
Menu, SetMaxBackup, Uncheck, 1
Menu, SetMaxBackup, Uncheck, 2
Menu, SetMaxBackup, Check, 3
Menu, SetMaxBackup, Uncheck, 4
Menu, SetMaxBackup, Uncheck, 5
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, 3, %StorageRootPath%piettyportable.ini, Settings, MaxBackup
return

SetMaxBackup4:
MaxBackup = 4
Menu, SetMaxBackup, Uncheck, 0
Menu, SetMaxBackup, Uncheck, 1
Menu, SetMaxBackup, Uncheck, 2
Menu, SetMaxBackup, Uncheck, 3
Menu, SetMaxBackup, Check, 4
Menu, SetMaxBackup, Uncheck, 5
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, 4, %StorageRootPath%piettyportable.ini, Settings, MaxBackup
return

SetMaxBackup5:
MaxBackup = 5
Menu, SetMaxBackup, Uncheck, 0
Menu, SetMaxBackup, Uncheck, 1
Menu, SetMaxBackup, Uncheck, 2
Menu, SetMaxBackup, Uncheck, 3
Menu, SetMaxBackup, Uncheck, 4
Menu, SetMaxBackup, Check, 5
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, 5, %StorageRootPath%piettyportable.ini, Settings, MaxBackup
return

SetNewWindowHotkey0:
Hotkey, #G, Off
Hotkey, #H, Off
Hotkey, #J, Off
Hotkey, #N, Off
Hotkey, #O, Off
Hotkey, #Q, Off
Hotkey, #T, Off
Hotkey, #W, Off
Hotkey, #X, Off
Hotkey, #Y, Off
Hotkey, #Z, Off
Menu, SetNewWindowHotkey, Check, %SetNewWindowHotkeyNone%
Menu, SetNewWindowHotkey, Uncheck, Win+G
Menu, SetNewWindowHotkey, Uncheck, Win+H
Menu, SetNewWindowHotkey, Uncheck, Win+J
Menu, SetNewWindowHotkey, Uncheck, Win+N
Menu, SetNewWindowHotkey, Uncheck, Win+O
Menu, SetNewWindowHotkey, Uncheck, Win+Q
Menu, SetNewWindowHotkey, Uncheck, Win+T
Menu, SetNewWindowHotkey, Uncheck, Win+W
Menu, SetNewWindowHotkey, Uncheck, Win+X
Menu, SetNewWindowHotkey, Uncheck, Win+Y
Menu, SetNewWindowHotkey, Uncheck, Win+Z
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, 0, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey
return

SetNewWindowHotkeyG:
Hotkey, #G, On
Hotkey, #H, Off
Hotkey, #J, Off
Hotkey, #N, Off
Hotkey, #O, Off
Hotkey, #Q, Off
Hotkey, #T, Off
Hotkey, #W, Off
Hotkey, #X, Off
Hotkey, #Y, Off
Hotkey, #Z, Off
Menu, SetNewWindowHotkey, Uncheck, %SetNewWindowHotkeyNone%
Menu, SetNewWindowHotkey, Check, Win+G
Menu, SetNewWindowHotkey, Uncheck, Win+H
Menu, SetNewWindowHotkey, Uncheck, Win+J
Menu, SetNewWindowHotkey, Uncheck, Win+N
Menu, SetNewWindowHotkey, Uncheck, Win+O
Menu, SetNewWindowHotkey, Uncheck, Win+Q
Menu, SetNewWindowHotkey, Uncheck, Win+T
Menu, SetNewWindowHotkey, Uncheck, Win+W
Menu, SetNewWindowHotkey, Uncheck, Win+X
Menu, SetNewWindowHotkey, Uncheck, Win+Y
Menu, SetNewWindowHotkey, Uncheck, Win+Z
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, G, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey
return

SetNewWindowHotkeyH:
Hotkey, #G, Off
Hotkey, #H, On
Hotkey, #J, Off
Hotkey, #N, Off
Hotkey, #O, Off
Hotkey, #Q, Off
Hotkey, #T, Off
Hotkey, #W, Off
Hotkey, #X, Off
Hotkey, #Y, Off
Hotkey, #Z, Off
Menu, SetNewWindowHotkey, Uncheck, %SetNewWindowHotkeyNone%
Menu, SetNewWindowHotkey, Uncheck, Win+G
Menu, SetNewWindowHotkey, Check, Win+H
Menu, SetNewWindowHotkey, Uncheck, Win+J
Menu, SetNewWindowHotkey, Uncheck, Win+N
Menu, SetNewWindowHotkey, Uncheck, Win+O
Menu, SetNewWindowHotkey, Uncheck, Win+Q
Menu, SetNewWindowHotkey, Uncheck, Win+T
Menu, SetNewWindowHotkey, Uncheck, Win+W
Menu, SetNewWindowHotkey, Uncheck, Win+X
Menu, SetNewWindowHotkey, Uncheck, Win+Y
Menu, SetNewWindowHotkey, Uncheck, Win+Z
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, H, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey
return

SetNewWindowHotkeyJ:
Hotkey, #G, Off
Hotkey, #H, Off
Hotkey, #J, On
Hotkey, #N, Off
Hotkey, #O, Off
Hotkey, #Q, Off
Hotkey, #T, Off
Hotkey, #W, Off
Hotkey, #X, Off
Hotkey, #Y, Off
Hotkey, #Z, Off
Menu, SetNewWindowHotkey, Uncheck, %SetNewWindowHotkeyNone%
Menu, SetNewWindowHotkey, Uncheck, Win+G
Menu, SetNewWindowHotkey, Uncheck, Win+H
Menu, SetNewWindowHotkey, Check, Win+J
Menu, SetNewWindowHotkey, Uncheck, Win+N
Menu, SetNewWindowHotkey, Uncheck, Win+O
Menu, SetNewWindowHotkey, Uncheck, Win+Q
Menu, SetNewWindowHotkey, Uncheck, Win+T
Menu, SetNewWindowHotkey, Uncheck, Win+W
Menu, SetNewWindowHotkey, Uncheck, Win+X
Menu, SetNewWindowHotkey, Uncheck, Win+Y
Menu, SetNewWindowHotkey, Uncheck, Win+Z
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, J, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey
return

SetNewWindowHotkeyN:
Hotkey, #G, Off
Hotkey, #H, Off
Hotkey, #J, Off
Hotkey, #N, On
Hotkey, #O, Off
Hotkey, #Q, Off
Hotkey, #T, Off
Hotkey, #W, Off
Hotkey, #X, Off
Hotkey, #Y, Off
Hotkey, #Z, Off
Menu, SetNewWindowHotkey, Uncheck, %SetNewWindowHotkeyNone%
Menu, SetNewWindowHotkey, Uncheck, Win+G
Menu, SetNewWindowHotkey, Uncheck, Win+H
Menu, SetNewWindowHotkey, Uncheck, Win+J
Menu, SetNewWindowHotkey, Check, Win+N
Menu, SetNewWindowHotkey, Uncheck, Win+O
Menu, SetNewWindowHotkey, Uncheck, Win+Q
Menu, SetNewWindowHotkey, Uncheck, Win+T
Menu, SetNewWindowHotkey, Uncheck, Win+W
Menu, SetNewWindowHotkey, Uncheck, Win+X
Menu, SetNewWindowHotkey, Uncheck, Win+Y
Menu, SetNewWindowHotkey, Uncheck, Win+Z
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, N, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey
return

SetNewWindowHotkeyO:
Hotkey, #G, Off
Hotkey, #H, Off
Hotkey, #J, Off
Hotkey, #N, Off
Hotkey, #O, On
Hotkey, #Q, Off
Hotkey, #T, Off
Hotkey, #W, Off
Hotkey, #X, Off
Hotkey, #Y, Off
Hotkey, #Z, Off
Menu, SetNewWindowHotkey, Uncheck, %SetNewWindowHotkeyNone%
Menu, SetNewWindowHotkey, Uncheck, Win+G
Menu, SetNewWindowHotkey, Uncheck, Win+H
Menu, SetNewWindowHotkey, Uncheck, Win+J
Menu, SetNewWindowHotkey, Uncheck, Win+N
Menu, SetNewWindowHotkey, Check, Win+O
Menu, SetNewWindowHotkey, Uncheck, Win+Q
Menu, SetNewWindowHotkey, Uncheck, Win+T
Menu, SetNewWindowHotkey, Uncheck, Win+W
Menu, SetNewWindowHotkey, Uncheck, Win+X
Menu, SetNewWindowHotkey, Uncheck, Win+Y
Menu, SetNewWindowHotkey, Uncheck, Win+Z
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, O, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey
return

SetNewWindowHotkeyQ:
Hotkey, #G, Off
Hotkey, #H, Off
Hotkey, #J, Off
Hotkey, #N, Off
Hotkey, #O, Off
Hotkey, #Q, On
Hotkey, #T, Off
Hotkey, #W, Off
Hotkey, #X, Off
Hotkey, #Y, Off
Hotkey, #Z, Off
Menu, SetNewWindowHotkey, Uncheck, %SetNewWindowHotkeyNone%
Menu, SetNewWindowHotkey, Uncheck, Win+G
Menu, SetNewWindowHotkey, Uncheck, Win+H
Menu, SetNewWindowHotkey, Uncheck, Win+J
Menu, SetNewWindowHotkey, Uncheck, Win+N
Menu, SetNewWindowHotkey, Uncheck, Win+O
Menu, SetNewWindowHotkey, Check, Win+Q
Menu, SetNewWindowHotkey, Uncheck, Win+T
Menu, SetNewWindowHotkey, Uncheck, Win+W
Menu, SetNewWindowHotkey, Uncheck, Win+X
Menu, SetNewWindowHotkey, Uncheck, Win+Y
Menu, SetNewWindowHotkey, Uncheck, Win+Z
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, Q, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey
return

SetNewWindowHotkeyT:
Hotkey, #G, Off
Hotkey, #H, Off
Hotkey, #J, Off
Hotkey, #N, Off
Hotkey, #O, Off
Hotkey, #Q, Off
Hotkey, #T, On
Hotkey, #W, Off
Hotkey, #X, Off
Hotkey, #Y, Off
Hotkey, #Z, Off
Menu, SetNewWindowHotkey, Uncheck, %SetNewWindowHotkeyNone%
Menu, SetNewWindowHotkey, Uncheck, Win+G
Menu, SetNewWindowHotkey, Uncheck, Win+H
Menu, SetNewWindowHotkey, Uncheck, Win+J
Menu, SetNewWindowHotkey, Uncheck, Win+N
Menu, SetNewWindowHotkey, Uncheck, Win+O
Menu, SetNewWindowHotkey, Uncheck, Win+Q
Menu, SetNewWindowHotkey, Check, Win+T
Menu, SetNewWindowHotkey, Uncheck, Win+W
Menu, SetNewWindowHotkey, Uncheck, Win+X
Menu, SetNewWindowHotkey, Uncheck, Win+Y
Menu, SetNewWindowHotkey, Uncheck, Win+Z
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, T, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey
return

SetNewWindowHotkeyW:
Hotkey, #G, Off
Hotkey, #H, Off
Hotkey, #J, Off
Hotkey, #N, Off
Hotkey, #O, Off
Hotkey, #Q, Off
Hotkey, #T, Off
Hotkey, #W, On
Hotkey, #X, Off
Hotkey, #Y, Off
Hotkey, #Z, Off
Menu, SetNewWindowHotkey, Uncheck, %SetNewWindowHotkeyNone%
Menu, SetNewWindowHotkey, Uncheck, Win+G
Menu, SetNewWindowHotkey, Uncheck, Win+H
Menu, SetNewWindowHotkey, Uncheck, Win+J
Menu, SetNewWindowHotkey, Uncheck, Win+N
Menu, SetNewWindowHotkey, Uncheck, Win+O
Menu, SetNewWindowHotkey, Uncheck, Win+Q
Menu, SetNewWindowHotkey, Uncheck, Win+T
Menu, SetNewWindowHotkey, Check, Win+W
Menu, SetNewWindowHotkey, Uncheck, Win+X
Menu, SetNewWindowHotkey, Uncheck, Win+Y
Menu, SetNewWindowHotkey, Uncheck, Win+Z
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, W, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey
return

SetNewWindowHotkeyX:
Hotkey, #G, Off
Hotkey, #H, Off
Hotkey, #J, Off
Hotkey, #N, Off
Hotkey, #O, Off
Hotkey, #Q, Off
Hotkey, #T, Off
Hotkey, #W, Off
Hotkey, #X, On
Hotkey, #Y, Off
Hotkey, #Z, Off
Menu, SetNewWindowHotkey, Uncheck, %SetNewWindowHotkeyNone%
Menu, SetNewWindowHotkey, Uncheck, Win+G
Menu, SetNewWindowHotkey, Uncheck, Win+H
Menu, SetNewWindowHotkey, Uncheck, Win+J
Menu, SetNewWindowHotkey, Uncheck, Win+N
Menu, SetNewWindowHotkey, Uncheck, Win+O
Menu, SetNewWindowHotkey, Uncheck, Win+Q
Menu, SetNewWindowHotkey, Uncheck, Win+T
Menu, SetNewWindowHotkey, Uncheck, Win+W
Menu, SetNewWindowHotkey, Check, Win+X
Menu, SetNewWindowHotkey, Uncheck, Win+Y
Menu, SetNewWindowHotkey, Uncheck, Win+Z
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, X, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey
return

SetNewWindowHotkeyY:
Hotkey, #G, Off
Hotkey, #H, Off
Hotkey, #J, Off
Hotkey, #N, Off
Hotkey, #O, Off
Hotkey, #Q, Off
Hotkey, #T, Off
Hotkey, #W, Off
Hotkey, #X, Off
Hotkey, #Y, On
Hotkey, #Z, Off
Menu, SetNewWindowHotkey, Uncheck, %SetNewWindowHotkeyNone%
Menu, SetNewWindowHotkey, Uncheck, Win+G
Menu, SetNewWindowHotkey, Uncheck, Win+H
Menu, SetNewWindowHotkey, Uncheck, Win+J
Menu, SetNewWindowHotkey, Uncheck, Win+N
Menu, SetNewWindowHotkey, Uncheck, Win+O
Menu, SetNewWindowHotkey, Uncheck, Win+Q
Menu, SetNewWindowHotkey, Uncheck, Win+T
Menu, SetNewWindowHotkey, Uncheck, Win+W
Menu, SetNewWindowHotkey, Uncheck, Win+X
Menu, SetNewWindowHotkey, Check, Win+Y
Menu, SetNewWindowHotkey, Uncheck, Win+Z
FileSetAttrib, -RHS, %StorageRootPath%piettyportable.ini
IniWrite, Y, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey
return

SetNewWindowHotkeyZ:
Hotkey, #G, Off
Hotkey, #H, Off
Hotkey, #J, Off
Hotkey, #N, Off
Hotkey, #O, Off
Hotkey, #Q, Off
Hotkey, #T, Off
Hotkey, #W, Off
Hotkey, #X, Off
Hotkey, #Y, Off
Hotkey, #Z, On
Menu, SetNewWindowHotkey, Uncheck, %SetNewWindowHotkeyNone%
Menu, SetNewWindowHotkey, Uncheck, Win+G
Menu, SetNewWindowHotkey, Uncheck, Win+H
Menu, SetNewWindowHotkey, Uncheck, Win+J
Menu, SetNewWindowHotkey, Uncheck, Win+N
Menu, SetNewWindowHotkey, Uncheck, Win+O
Menu, SetNewWindowHotkey, Uncheck, Win+Q
Menu, SetNewWindowHotkey, Uncheck, Win+T
Menu, SetNewWindowHotkey, Uncheck, Win+W
Menu, SetNewWindowHotkey, Uncheck, Win+X
Menu, SetNewWindowHotkey, Uncheck, Win+Y
Menu, SetNewWindowHotkey, Check, Win+Z
IniWrite, Z, %StorageRootPath%piettyportable.ini, Settings, NewWindowHotkey
return

#G::
Goto, IsRunning
return

#H::
Goto, IsRunning
return

#J::
Goto, IsRunning
return

#N::
Goto, IsRunning
return

#O::
Goto, IsRunning
return

#Q::
Goto, IsRunning
return

#T::
Goto, IsRunning
return

#W::
Goto, IsRunning
return

#X::
Goto, IsRunning
return

#Y::
Goto, IsRunning
return

#Z::
Goto, IsRunning
return

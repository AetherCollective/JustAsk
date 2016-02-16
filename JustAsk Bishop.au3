#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=D:\Dropbox\Documents\Scripts\Maple\JustAsk-Full.exe
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Run_After=copy "%out%" C:\wamp\www\dl
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include-once
#include "ImageSearch.au3"
#include <GDIPlus.au3>
#include <Misc.au3>
ProcessSetPriority(@ScriptName, 3)
ProcessSetPriority("AutoIt3.exe", 3)
_Singleton("Simply Ask")
_GDIPlus_Startup()
Opt("MouseCoordMode", 1)
Opt("PixelCoordMode", 2)
Opt("TrayIconDebug", 1)
Opt("MouseClickDelay", 30)
Opt("MouseClickDownDelay", 30)
Opt("SendKeyDelay", 30)
Opt("SendKeydownDelay", 30)
FileChangeDir(@ScriptDir)
FileInstall("ImageSearchDLL.dll", "ImageSearchDLL.dll", 1)
FileInstall("ImageSearch.au3", "ImageSearch.au3", 1)
FileInstall("MapleHelper.au3", "MapleHelper.au3", 0)
FileInstall("bless.png", "bless.png", 1);
FileInstall("commands.png", "commands.png", 1)
FileInstall("dispel.png", "dispel.png", 1)
FileInstall("door.png", "door.png", 1);
FileInstall("Fix100.png", "Fix100.png", 1)
FileInstall("fountain.png", "fountain.png", 1)
FileInstall("genesis.png", "genesis.png", 1)
FileInstall("heal.png", "heal.png", 1);
FileInstall("hs.png", "hs.png", 1);
FileInstall("maplewarrior.png", "maplewarrior.png", 1);
FileInstall("mw.png", "mw.png", 1);
FileInstall("revive.png", "revive.png", 1)
FileInstall("shell.png", "shell.png", 1)
FileInstall("JustAsk.ini", "JustAsk.ini", 0);
WinWait("MapleStory")
Global $hwndpos = WinGetPos("MapleStory")
Global $Lastrun = 0, $iX, $iY, $iLeft = $hwndpos[0], $iTop = $hwndpos[1], $iRight = $hwndpos[2] + $hwndpos[0], $iBottom = $hwndpos[3] + $hwndpos[1], $hs = IniRead("JustAsk.ini", "keys", "hs", "{space}"), $quit = IniRead("JustAsk.ini", "keys", "quit", "^{escape}"), $sit = IniRead("JustAsk.ini", "keys", "sit", "t"), $door = IniRead("JustAsk.ini", "keys", "door", "`"), $bless = IniRead("JustAsk.ini", "keys", "bless", "d"), $shell = IniRead("JustAsk.ini", "keys", "shell", "{ins}"), $mw = IniRead("JustAsk.ini", "keys", "maplewarrior", "o"), $heal = IniRead("JustAsk.ini", "keys", "Heal", "{pgdn}"), $revive = IniRead("JustAsk.ini", "keys", "revive", "v"), $genesis = IniRead("JustAsk.ini", "keys", "genesis", "c"), $dispel = IniRead("JustAsk.ini", "keys", "dispel", "{end}"), $fountain = IniRead("JustAsk.ini", "keys", "fountain", "{pgup}"), $partychat = IniRead("JustAsk.ini", "keys", "PartyChat", "3"), $resetkey = IniRead("JustAsk.ini", "keys", "FixDetection", "{f7}"), $key, $nocd, $IsOnChair = 1
Global $delay = 1000 / 25
If $sit = "off" Then $IsOnChair = 0
HotKeySet($quit, "_exit")
HotKeySet($resetkey, "GetMapleWin")
WinActivate("MapleStory")
idle()
Func idle()
	While 1
		$key = $hs
		_FindImageClick(@ScriptDir & "\hs.png")
		Sleep($delay)
		$key = $bless
		_FindImageClick(@ScriptDir & "\bless.png")
		Sleep($delay)
		$key = $door
		_FindImageClick(@ScriptDir & "\door.png")
		Sleep($delay)
		$key = $heal
		_FindImageClick(@ScriptDir & "\heal.png")
		Sleep($delay)
		$key = $shell
		_FindImageClick(@ScriptDir & "\shell.png")
		Sleep($delay)
		$key = $mw
		_FindImageClick(@ScriptDir & "\mw.png")
		Sleep($delay)
		_FindImageClick(@ScriptDir & "\maplewarrior.png")
		Sleep($delay)
		$key = $revive
		_FindImageClick(@ScriptDir & "\revive.png")
		Sleep($delay)
		$key = $genesis
		_FindImageClick(@ScriptDir & "\genesis.png")
		Sleep($delay)
		$key = $fountain
		_FindImageClick(@ScriptDir & "\fountain.png")
		Sleep($delay)
		$key = $dispel
		_FindImageClick(@ScriptDir & "\dispel.png")
		Sleep($delay)
		$key = "reset"
		_FindImageClick(@ScriptDir & "\fix100.png")
		Sleep($delay)
		$key = "commands"
		_FindImageClick(@ScriptDir & "\commands.png")
	WEnd
EndFunc   ;==>idle
Func _FindImageClick($sImgPath);the function that searches
	$iX = 0
	$iY = 0
	$Lastrun = 0
	_GDIPlus_Startup()
	Local $hImage = _GDIPlus_ImageLoadFromFile($sImgPath)
	Local $hHBmp = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
	Local $iRet = _ImageSearchArea($hHBmp, 1, $iLeft, $iTop, $iRight, $iBottom, $iX, $iY, 5, 0)
	_WinAPI_DeleteObject($hHBmp)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
	If $iRet = 1 Then
		If $key = "reset" Then Reset()
		If $key = "commands" Then commands()
		If Not $key = "" Then
			FixFocus()
			If $IsOnChair = 1 Then UnmountChair()
			ControlSend("MapleStory", "", "", $key)
			If $IsOnChair = 1 Then mountChair()
		EndIf
		If $iRet = 1 Then $Lastrun = 1
		If $nocd = 1 Then
			Sleep(0)
		ElseIf $IsOnChair = 1 Then
			Sleep(1500)
		Else
			Sleep(4500)
		EndIf
	EndIf
EndFunc   ;==>_FindImageClick
Func FixFocus()
	ControlSend("MapleStory", "", "", "{esc}")
	Sleep(30)
	ControlSend("MapleStory", "", "", "{esc}")
	Sleep(30)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(30)
	ControlSend("MapleStory", "", "", "{esc}")
	Sleep(100)
EndFunc   ;==>FixFocus
Func UnmountChair()
	ControlSend("MapleStory", "", "", "{lalt down}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{lalt up}")
	Sleep(1000)
EndFunc   ;==>UnmountChair
Func mountChair()
	If Not $IsOnChair = 1 Then Return
	Sleep(1000)
	If $key = $heal Then Sleep(4500)
	If $key = $genesis Then Sleep(4500)
	ControlSend("MapleStory", "", "", $sit)
	;_SetIsRunningState("no")
EndFunc   ;==>mountChair
Func _exit()
	Exit
EndFunc   ;==>_exit
Func Reset()
	FixFocus()
	If $IsOnChair = 1 Then UnmountChair()
	ControlSend("MapleStory", "", "", "{ins}")
	Sleep(1500)
	ControlSend("MapleStory", "", "", "{`}")
	Sleep(1500)
	ControlSend("MapleStory", "", "", "{up}")
	Sleep(5000)
	ControlSend("MapleStory", "", "", "{up}")
	Sleep(4500)
	$key = ""
	If $IsOnChair = 1 Then mountChair()
	;_SetIsRunningState("no")
EndFunc   ;==>Reset
Func GetMapleWin()
	$hwndpos = ""
	$iTop = ""
	$iBottom = ""
	$iLeft = ""
	$iRight = ""
	$hwndpos = WinGetPos("MapleStory")
	$iLeft = $hwndpos[0]
	$iTop = $hwndpos[1]
	$iRight = $hwndpos[2] + $hwndpos[0]
	$iBottom = $hwndpos[3] + $hwndpos[1]
EndFunc   ;==>GetMapleWin
Func commands()
	FixFocus()
	ControlSend("MapleStory", "", "", $partychat)
	Sleep(500)
	ControlSend("MapleStory", "", "", "Ask for any of the following and you shall receive{!}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "Commands: hs, bless, dispel, door, fountain, heal, genesis,")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "maplewarrior, mw, revive, shell, commands")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "Notes: Doing fix100 will fix buffs not being applied.")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "MUST BE ALL LOWERCASE IN PARTY CHAT{!}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(5000)
	;_SetIsRunningState("no")
	idle()
EndFunc   ;==>commands

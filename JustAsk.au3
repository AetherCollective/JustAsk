#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Includes\Icon.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include-once
#include "Includes\ImageSearch.au3"
#include <GDIPlus.au3>
#include <Misc.au3>
ProcessSetPriority(@ScriptName, 3)
ProcessSetPriority("AutoIt3.exe", 3)
_Singleton("JustAsk")
_GDIPlus_Startup()
Opt("MouseCoordMode", 1)
Opt("PixelCoordMode", 2)
Opt("TrayIconDebug", 1)
Opt("MouseClickDelay", 30)
Opt("MouseClickDownDelay", 30)
Opt("SendKeyDelay", 30)
Opt("SendKeydownDelay", 30)
Opt("WinTitleMatchMode", 3)
DirCreate(@TempDir & "\BetaLeaf Software\JustAsk\")
FileChangeDir(@TempDir & "\BetaLeaf Software\JustAsk")
FileInstall("Includes\ImageSearchDLL.dll", @TempDir & "\BetaLeaf Software\JustAsk\ImageSearchDLL.dll", 1)
FileInstall("Includes\ImageSearch.au3", @TempDir & "\BetaLeaf Software\JustAsk\ImageSearch.au3", 1)
FileInstall("Images\bless.png", @TempDir & "\BetaLeaf Software\JustAsk\bless.png", 1)
FileInstall("Images\commands.png", @TempDir & "\BetaLeaf Software\JustAsk\commands.png", 1)
FileInstall("Images\dispel.png", @TempDir & "\BetaLeaf Software\JustAsk\dispel.png", 1)
FileInstall("Images\door.png", @TempDir & "\BetaLeaf Software\JustAsk\door.png", 1)
FileInstall("Images\Fix100.png", @TempDir & "\BetaLeaf Software\JustAsk\Fix100.png", 1)
FileInstall("Images\fountain.png", @TempDir & "\BetaLeaf Software\JustAsk\fountain.png", 1)
FileInstall("Images\genesis.png", @TempDir & "\BetaLeaf Software\JustAsk\genesis.png", 1)
FileInstall("Images\heal.png", @TempDir & "\BetaLeaf Software\JustAsk\heal.png", 1)
FileInstall("Images\hs.png", @TempDir & "\BetaLeaf Software\JustAsk\hs.png", 1)
FileInstall("Images\maplewarrior.png", @TempDir & "\BetaLeaf Software\JustAsk\maplewarrior.png", 1)
FileInstall("Images\mw.png", @TempDir & "\BetaLeaf Software\JustAsk\mw.png", 1)
FileInstall("Images\revive.png", @TempDir & "\BetaLeaf Software\JustAsk\revive.png", 1)
FileInstall("Images\shell.png", @TempDir & "\BetaLeaf Software\JustAsk\shell.png", 1)
FileInstall("Images\partyaccept.png", @TempDir & "\BetaLeaf Software\JustAsk\partyaccept.png", 1)
FileInstall("Images\partyinvite.png", @TempDir & "\BetaLeaf Software\JustAsk\partyinvite.png", 1)
FileInstall("Images\leaveparty.png", @TempDir & "\BetaLeaf Software\JustAsk\leaveparty.png", 1)
FileInstall("JustAsk.ini", @ScriptDir&"\JustAsk.ini", 0)
Global $hwnd = WinWait("MapleStory")
Global $hwndpos = WinGetPos("MapleStory")
Global $command, $nocd, $IsOnChair = 1, $iX, $iY
Global $iLeft = $hwndpos[0]
Global $iTop = $hwndpos[1]
Global $iRight = $hwndpos[2] + $hwndpos[0]
Global $iBottom = $hwndpos[3] + $hwndpos[1]
Global $hs = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "hs", "{space}")
Global $door = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "door", "`")
Global $bless = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "bless", "d")
Global $shell = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "shell", "{ins}")
Global $mw = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "maplewarrior", "o")
Global $heal = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "Heal", "{pgdn}")
Global $revive = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "revive", "v")
Global $genesis = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "genesis", "c")
Global $dispel = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "dispel", "{end}")
Global $fountain = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "fountain", "{pgup}")
Global $sit = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "sit", "t")
Global $partychat = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "PartyChat", "3")
Global $resetkey = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "FixDetection", "{f7}")
Global $quit = IniRead(@ScriptDir&"\JustAsk.ini", "keys", "quit", "^{escape}")
Global $Logging = IniRead(@ScriptDir&"\JustAsk.ini", "Settings", "Logging", True)
Global $commands = _
		[ _
		["HolySymbol", $hs], _
		["Door", $door], _
		["Bless", $bless], _
		["Shell", $shell], _
		["MapleWarrior", $mw], _
		["Heal", $heal], _
		["Revive", $revive], _
		["Genesis", $genesis], _
		["Dispel", $dispel], _
		["Fountain", $fountain], _
		["PartyInvite", "partyinvite"], _
		["LeaveParty", "leaveparty"], _
		["Commands", "commands"], _
		["Fix100", "reset"]]
If $sit = "off" Then $IsOnChair = 0
HotKeySet($quit, "_exit")
HotKeySet($resetkey, "GetMapleWin")
WinActivate("MapleStory")
idle()
Func idle()
	While 1
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\hs.png", $hs)
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\bless.png", $bless)
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\door.png", $door)
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\heal.png", $heal)
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\shell.png", $shell)
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\mw.png", $mw)
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\maplewarrior.png", $mw)
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\revive.png", $revive)
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\genesis.png", $genesis)
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\fountain.png", $fountain)
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\dispel.png", $dispel)
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\fix100.png", "reset")
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\commands.png", "commands")
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\leaveparty.png", "leaveparty")
		_FindImage(@TempDir & "\BetaLeaf Software\JustAsk\partyinvite.png", "partyinvite")
	WEnd
EndFunc   ;==>idle
Func _FindImage($sImgPath, $command) ;the function that searches
	_GDIPlus_Startup()
	Local $hImage = _GDIPlus_ImageLoadFromFile($sImgPath)
	Local $hHBmp = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
	Local $iRet = _ImageSearchArea($hHBmp, 1, $iLeft, $iTop, $iRight, $iBottom, $iX, $iY, 5, 0)
	_WinAPI_DeleteObject($hHBmp)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
	If $iRet = 1 Then
		If $Logging = True Then
			For $i = 0 To UBound($commands) - 1
				If $commands[$i][1] = $command Then $currentcommand = $i
			Next
			$Log = IniRead(@ScriptDir & "\Log.txt", "Logging", $commands[$currentcommand][0], 0)
			IniWrite(@ScriptDir & "\Log.txt", "Logging", $commands[$currentcommand][0], $Log + 1)
		EndIf
		If $command = "reset" Then
			Reset()
			Return 1
		EndIf
		If $command = "commands" Then
			commands()
			Return 1
		EndIf
		If $command = "leaveparty" Then
			leaveparty()
			Return 1
		EndIf
		If $command = "partyinvite" Then
			partyinvite()
			Return 1
		EndIf
		If Not $command = "" Then
			FixFocus()
			If $IsOnChair = 1 Then UnmountChair()
			ControlSend("MapleStory", "", "", $command)
			If $IsOnChair = 1 Then mountChair()
		EndIf
		If $nocd = 1 Then
			Sleep(Random(0, 200))
		ElseIf $IsOnChair = 1 Then
			Sleep(Random(1500, 1800))
		Else
			Sleep(Random(4500, 5000))
		EndIf
		Return 1
	EndIf
EndFunc   ;==>_FindImage
Func FixFocus()
	ControlSend("MapleStory", "", "", "{esc}")
	Sleep(30)
	ControlSend("MapleStory", "", "", "{esc}")
	Sleep(30)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(30)
	ControlSend("MapleStory", "", "", "{esc}")
	Sleep(200)
EndFunc   ;==>FixFocus
Func UnmountChair()
	ControlSend("MapleStory", "", "", "{lalt down}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{lalt up}")
	Sleep(Random(1000, 1200))
EndFunc   ;==>UnmountChair
Func mountChair()
	If Not $IsOnChair = 1 Then Return
	Sleep(Random(1000, 1200))
	If $command = $heal Then Sleep(4500)
	If $command = $genesis Then Sleep(4500)
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
	If $IsOnChair = 1 Then mountChair()
	;_SetIsRunningState("no")
EndFunc   ;==>Reset
Func GetMapleWin()
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
	Local $clipstorage = ClipGet()
	ClipPut("Party Commands: hs, bless, dispel, door, fountain, heal,")
	ControlSend("MapleStory", "", "", "+{ins}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(900)
	ClipPut("genesis, maplewarrior, mw, revive, shell, fix100, commands.")
	ControlSend("MapleStory", "", "", "+{ins}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(900)
	ClipPut('The command "fix100" will fix buffs not being applied.')
	ControlSend("MapleStory", "", "", "+{ins}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(900)
	ClipPut('Party Commands must be sent in party chat and in lowercase.')
	ControlSend("MapleStory", "", "", "+{ins}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(900)
	ClipPut('===')
	ControlSend("MapleStory", "", "", "+{ins}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(900)
	ClipPut("Party Management Commands: partyinvite, leaveparty.")
	ControlSend("MapleStory", "", "", "+{ins}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(900)
	ClipPut('The command "partyinvite" will accept a request to join a party.')
	ControlSend("MapleStory", "", "", "+{ins}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(900)
	ClipPut('The command "leaveparty" will make me leave the party.')
	ControlSend("MapleStory", "", "", "+{ins}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(900)
	ClipPut('Party Management Commands only work in all chat with no quote rings &')
	ControlSend("MapleStory", "", "", "+{ins}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(900)
	ClipPut("must be sent in lowercase. Used to regain control of a dead party.")
	ControlSend("MapleStory", "", "", "+{ins}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(900)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(5500)
	ClipPut($clipstorage)
EndFunc   ;==>commands
Func partyinvite()
	_GDIPlus_Startup()
	Local $hImage = _GDIPlus_ImageLoadFromFile(@TempDir & "\BetaLeaf Software\JustAsk\partyaccept.png")
	Local $hHBmp = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
	Local $iRet = _ImageSearchArea($hHBmp, 1, $iLeft, $iTop, $iRight, $iBottom, $iX, $iY, 5, 0)
	_WinAPI_DeleteObject($hHBmp)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
	If $iRet = 1 Then
		WinActivate("MapleStory")
		MouseClick("Left", $iX, $iY, 1, 0)
	EndIf
	Sleep(1000)
EndFunc   ;==>partyinvite
Func leaveparty()
	FixFocus()
	Local $clipstorage = ClipGet()
	ClipPut("/leaveparty")
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "+{ins}")
	Sleep(100)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(900)
	ControlSend("MapleStory", "", "", "{enter}")
	Sleep(5500)
	ClipPut($clipstorage)
EndFunc   ;==>leaveparty

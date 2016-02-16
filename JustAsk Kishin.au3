#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Description=Type "kishin" in party chat.
#AutoIt3Wrapper_Res_Fileversion=1
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "ImageSearch.au3"
#include <GDIPlus.au3>
#include <Misc.au3>
FileChangeDir(@ScriptDir)
FileInstall("ImageSearch.au3", "ImageSearch.au3", 1)
FileInstall("ImageSearchDLL.dll", "ImageSearchDLL.dll", 1)
FileInstall("kishin.png", "kishin.png", 1)
If Not FileExists("kishin.ini") Then
	FileInstall("kishin.ini", "kishin.ini", 0)
	Exit
EndIf
WinActivate("MapleStory")
WinWaitActive("MapleStory")
Global $Lastrun = 0, $iX, $iY
Opt("MouseCoordMode", 1)
Opt("PixelCoordMode", 2)
Opt("TrayIconDebug", 1)
Opt("MouseClickDelay", 30)
Opt("MouseClickDownDelay", 30)
Opt("SendKeyDelay", 30)
Opt("SendKeydownDelay", 15)
Global $key = IniRead("kishin.ini", "keys", "kishin", "{space}")
Global $quit = IniRead("kishin.ini", "keys", "quit", "^{escape}")
Global $sit = IniRead("kishin.ini", "keys", "sit", "t")
ProcessSetPriority(@ScriptName, 4)
ProcessSetPriority("AutoIt3.exe", 4)
Global $IsOnChair = 1
if $sit="off" then $IsOnChair=0
_Singleton("Simply Ask - kishin")
_GDIPlus_Startup()
HotKeySet($quit, "_exit")
idle()
Func idle()
	While 1
		Sleep(1000 / 60)
		_FindImageClick(@ScriptDir & "\kishin.png")
		If $Lastrun = 1 Then Sleep(5500)
	WEnd
EndFunc   ;==>idle
Func _FindImageClick($sImgPath);the function that searches
	_GDIPlus_Startup()
	Local $hImage
	$hImage = _GDIPlus_ImageLoadFromFile($sImgPath)
	Local $hHBmp
	$hHBmp = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
	$iX = 0
	$iY = 0
	$Lastrun = 0
	Local $iRet = 0
	$iRet = _ImageSearch($hHBmp, 1, $iX, $iY, 5) ;5: tolerance, if it does not work for you rise it (up to 255)

	If $iRet = 1 Then
		FixFocus()
		If $IsOnChair = 1 Then UnmountChair()
		ControlSend("MapleStory", "", "", $key)
		If $IsOnChair = 1 Then mountChair()
		If $iRet = 1 Then $Lastrun = 1
	EndIf

	_WinAPI_DeleteObject($hHBmp)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
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
	ControlSend("MapleStory", "", "", $sit)
EndFunc   ;==>mountChair
Func _exit()
	Exit
EndFunc   ;==>_exit

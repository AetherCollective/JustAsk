Global $hwndpos = "", $iTop = "", $iBottom = "", $iLeft = "", $iRight = "", $hwndposTdiff = "", $hwndposTimer = "", $hwndposTimer = TimerInit(), $time1base = "30000", $time1 = "0"
Func _GetMapleWindow();begin imagesearch
	$hwndposTdiff = TimerDiff($hwndposTimer)
	If $hwndposTdiff > $time1 Then
		$time1 = $time1 + $time1base
		$hwndpos = "0"
		$iTop = "0"
		$iBottom = "0"
		$iLeft = "0"
		$iRight = "0"
		$hwndpos = WinGetPos("MapleStory")
		$iLeft = $hwndpos[0]
		$iTop = $hwndpos[1]
		$iRight = $hwndpos[2] + $hwndpos[0]
		$iBottom = $hwndpos[3] + $hwndpos[1]
		;MsgBox(0, "Ms", $iLeft & "x" & $iTop & " " & $iRight & "x" & $iBottom)
	EndIf
EndFunc   ;==>_GetMapleWindow

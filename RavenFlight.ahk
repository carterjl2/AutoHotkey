; Developed by: Corey Swoyer
; Used to replace built in EVE Online Auto Pilot
; Be sure to place the ScreenCapture.ahk into the same location as this script


#Include ScreenCapture.ahk

; ########################### Verify Settings INI and promt for setup if not exists ###########################
CheckSettings()

IniRead, OverPos1, AutopilotSettings.ini,  OverviewPos, Point1
IniRead, OverPos2, AutopilotSettings.ini,  OverviewPos, Point2
IniRead, OverPos3, AutopilotSettings.ini,  OverviewPos, Point3
IniRead, OverPos4, AutopilotSettings.ini,  OverviewPos, Point4
IniRead, WarpPos1, AutopilotSettings.ini,  WarpPos, Warp1
IniRead, WarpPos2, AutopilotSettings.ini,  WarpPos, Warp2
IniRead, JumpPos1, AutopilotSettings.ini,  JumpPos, Jump1
IniRead, JumpPos2, AutopilotSettings.ini,  JumpPos, Jump2
IniRead, Warp1, AutopilotSettings.ini,  WarpPos, Point1
IniRead, Warp2, AutopilotSettings.ini,  WarpPos, Point2
IniRead, Warp3, AutopilotSettings.ini,  WarpPos, Point3
IniRead, Warp4, AutopilotSettings.ini,  WarpPos, Point4

WinWait, EVE, 
IfWinNotActive, EVE, , WinActivate, EVE, 
WinWaitActive, EVE, 

; ########################### Search for waypoint image and loop until missing ###########################
CoordMode Pixel
ImageSearch, FoundX, FoundY, %OverPos1%, %OverPos2%, %OverPos3%, %OverPos4%, waypoint.bmp

if ErrorLevel = 2
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
    MsgBox Icon could not be found on the screen.
else

loop
{
CoordMode Pixel
ImageSearch, FoundX, FoundY, %OverPos1%, %OverPos2%, %OverPos3%, %OverPos4%, waypoint.bmp

if ErrorLevel = 2
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
    Goto, End
else
	CoordMode Mouse
	varxpos := FoundX + 4
	varypos := FoundY + 4
	Click, %varxpos%, %varypos%, EVE
	Sleep 100
	Click, %WarpPos1%, %WarpPos2%
	Sleep 90000
loop
{
	PixelSearch,,, %Warp1%, %Warp2%, %Warp3%, %Warp4%, 0xBD8E56, 10, Fast
	If ErrorLevel
		;MsgBox, That color was not found
		Break
	Else
		;MsgBox, A color near that was found!
		Continue
}

;	WarpEnd:
	Sleep 8000
	Click %JumpPos1%, %JumpPos2%
	Sleep 15000
}

End:
SoundPlay, full_stop.wav, wait
MsgBox Destination reached..


; ########################### Procedures Only Below This Point ###########################

CheckSettings()
{
	IfNotExist, AutopilotSettings.ini

	{
	MsgBox Please read the instructions before clicking ok to continue.
	
	TrayTip, Autopilot Setup, Please Move mouse to first overview point and press Alt.
	KeyWait, Alt, D
	CoordMode Mouse
	MouseGetPos, xpos1, ypos1
	OverPos1 = %xpos1%, %ypos1%
	TrayTip
	KeyWait, Alt, U

	TrayTip, Autopilot Setup, Please Move mouse to second overview point and press Alt.
	KeyWait, Alt, D
	CoordMode Mouse
	MouseGetPos, xpos2, ypos2
	OverPos2 = %xpos2%, %ypos2%
	TrayTip
	KeyWait, Alt, U

	TrayTip, Autopilot Setup, Please Move mouse to warp to zero button and press Alt.
	KeyWait, Alt, D
	CoordMode Mouse
	MouseGetPos, xpos3, ypos3
	WarpPos = %xpos3%, %ypos3%
	TrayTip
	KeyWait, Alt, U

	TrayTip, Autopilot Setup, Please Move mouse to jump button and press Alt.
	KeyWait, Alt, D
	CoordMode Mouse
	MouseGetPos, xpos4, ypos4
	JumpPos = %xpos4%, %ypos4%
	TrayTip
	KeyWait, Alt, U

	TrayTip, Autopilot Setup, Please Move mouse to first warp bar point and press Alt.
	KeyWait, Alt, D
	CoordMode Mouse
	MouseGetPos, xpos5, ypos5
	WarpPos1 = %xpos5%, %ypos5%
	TrayTip
	KeyWait, Alt, U

	TrayTip, Autopilot Setup, Please Move mouse to second warp bar point and press Alt.
	KeyWait, Alt, D
	CoordMode Mouse
	MouseGetPos, xpos6, ypos6
	WarpPos2 = %xpos6%, %ypos6%
	TrayTip
	KeyWait, Alt, U
	
	TrayTip, Autopilot Setup, Please move the cursor to the center of the next destination icon and press alt.
	KeyWait, Alt, D
	CaptureScreen()
	TrayTip
	KeyWait, Alt, U

	IniWrite, %xpos1%, AutopilotSettings.ini,  OverviewPos, Point1
	IniWrite, %ypos1%, AutopilotSettings.ini,  OverviewPos, Point2
	IniWrite, %xpos2%, AutopilotSettings.ini,  OverviewPos, Point3
	IniWrite, %ypos2%, AutopilotSettings.ini,  OverviewPos, Point4
	IniWrite, %xpos3%, AutopilotSettings.ini,  WarpPos, Warp1
	IniWrite, %ypos3%, AutopilotSettings.ini,  WarpPos, Warp2
	IniWrite, %xpos4%, AutopilotSettings.ini,  JumpPos, Jump1
	IniWrite, %ypos4%, AutopilotSettings.ini,  JumpPos, Jump2
	IniWrite, %xpos5%, AutopilotSettings.ini,  WarpPos, Point1
	IniWrite, %ypos5%, AutopilotSettings.ini,  WarpPos, Point2
	IniWrite, %xpos6%, AutopilotSettings.ini,  WarpPos, Point3
	IniWrite, %ypos6%, AutopilotSettings.ini,  WarpPos, Point4
	}
}

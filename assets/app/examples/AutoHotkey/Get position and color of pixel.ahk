; Autogenerated with DRAKON Editor 1.23
; AutoHotkey_L beta v1.7 code generator used


;Header starts here.
Goto, Free_Start
return ;This "return" is here to prevent unintended execution of code.
;Header ends here.


return ;This "return" is here to protect Hotkey type diagram from unintended execution.
Escape::
    ; item 16
    ExitApp
return


;Diagram "Free_Start".
return ;This "return" is here to protect Free type diagram from unintended execution.
Free_Start:
{} ;This empty block is there to prevent error caused by interaction of label and other code (for example function definition).
    ; item 7
    CoordMode, Pixel, Screen
    ; item 8
    CoordMode, Mouse, Screen
    ; item 9
    MsgBox, Press Control+Alt+Z to get pixel position and color at the current cursor position.
return


return ;This "return" is here to protect Hotkey type diagram from unintended execution.
^!z::
    ; item 10
    MouseGetPos, X, Y
    ; item 11
    PixelGetColor, Color, %X%, %Y%, Slow
    ; item 12
    MsgBox, Current cursor position is at X= %X%, Y= %Y% and that pixel has color= %Color%
return



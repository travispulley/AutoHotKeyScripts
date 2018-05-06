; reload AHK
^!r::Reload ; ctrl-alt-r

; resize a window and center it
^!w:: ; ctrl-alt-w
winWidth  = 2800
winHeight = 1620
WinMove, A, , (A_ScreenWidth/2)-(winWidth/2), (A_ScreenHeight/2)-(winHeight/2), winWidth, winHeight
return

; opens selected file in vscode from explorer, or activates vscode
; TODO - better file handling, support multiple selected files
^!e:: ; ctrl-alt-e
if WinActive("ahk_class CabinetWClass") { ; windows file explorer
  oCB := ClipboardAll  ; save clipboard contents
  Send, ^c
  ClipWait ;waits for the clipboard to have content
  Run, "C:\Program Files\Microsoft VS Code\Code.exe" "%clipboard%" ; use -n switch for new instance
  ClipBoard := oCB ; return original Clipboard contents
  return
}
else IfWinExist, ahk_exe Code.exe
  WinActivate
return

; toggles the active window to be always on top
^SPACE:: Winset, Alwaysontop, , A ; ctrl-space

; win-w, look up selection in wikipedia
#w:: 
Send, ^c 
Run, https://en.wikipedia.org/wiki/Special:Search?search=%Clipboard% 
Return

; win-g, look up selection in google (disables windows game bar)
#g:: 
Send, ^c 
Run, https://www.google.com/search?q=%Clipboard% 
Return

; win-d, look up selection in duckduckgo (disables show/hide desktop)
#d:: 
Send, ^c 
Run, https://duckduckgo.com/?q=%Clipboard% 
Return

; multiply scroll when alt is held
; TODO FIXME - why do browsers scale on this?
; !$WheelDown::Send, {WheelDown 3}
; !$WheelUp::Send, {WheelUp 3}
!$WheelDown::Send, {PgDn}
!$WheelUp::Send, {PgUp}

; secondary clipboard copy+paste
#c:: ; win-c copy
tempclip := clipboardAll
clipboard := ""
send ^c
clipWait, 2
word1 := clipboard
clipboard := tempclip
return

#v:: ; win-v paste
if (word1 = "")
return
tempclip := clipboardAll
clipboard := word1
send ^v
clipboard := tempclip
return

; default windows hotkey reference: https://support.microsoft.com/en-us/help/12445/windows-keyboard-shortcuts
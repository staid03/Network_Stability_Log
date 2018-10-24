;Best viewed in Notepad++ with the AHK syntax file installed.
;This file runs through AutoHotkey a highly versatile freeware scripting program.
;
; Language:       English
; Platform:       Windows 10
; Author:         staid03
; Version	Date		Author		Comments
;	0.1		24-OCT-18	staid03		Initial
;
;
; Script Function:
;    GUI for setting up an ongoing ping for monitoring the network
;
;functionality to add:
; null

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

Gui , Color , 339900
Gui , Font , s14
Gui , Add , Edit , vEditBit x15 y15 w170
Gui , Font , s16
Gui , Add , Text , x200 y18 , Destination IP Address/DNS Name
Gui , Font , s14
Gui , Add , Button , Default x15 , Begin Ping
Gui , Font , s12
Gui , Add , Button , x460 , Reset Gui
Gui , Show
Return

ButtonBeginPing:
Gui , Submit , NoHide
;going to assume user enters a correct IP address
Run , Network_Stability_Log.ahk %EditBit%
;MsgBox, EditBit was %EditBit%
Return

ButtonResetGui:
Gui , Submit , NoHide
Run , %A_ScriptFullPath%
Return
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

Debug = False
NumberOfPings = 50

Loop ,
{
    FormatTime, atime , , yyyyMMdd_HHmmss
    outfile = Ping_Results_%1%_%atime%.txt
    RunWait , %ComSpec% /c Ping -n %NumberOfPings% %1% > %outfile% ,, Min
    Parse_Log(outfile,Debug)
}
Return

Parse_Log(LogFile,Debug)
{
    Run , %LogFile%
    Errors_Found = False
    Loop , Read , %LogFile%
    {
        Stringreplace , checkForSpaces , A_LoopReadLine , %a_space% ,, A
        StringLen , checkForSpacesLen , checkForSpaces
        IfEqual, checkForSpacesLen , 0
        {
            Continue
        }

        IfNotInString, A_LoopReadLine , Reply from
        {
            IfNotInString, A_LoopReadLine , Pinging
            {
                IfNotInString, A_LoopReadLine , Ping statistics
                {
                    IfNotInString, A_LoopReadLine , Approximate
                    {
                        IfNotInString, A_LoopReadLine , Minimum
                        {
                            IfNotInString, A_LoopReadLine , Packets
                            {
                                Errors_Found = True
                                Break                  
                            }                    
                        }                            
                    }                    
                }                
            }
        }
    }
    IfEqual , Errors_Found , False
    {
        IfEqual , Debug , False
        {
            FileDelete , %LogFile%
        }
        Else
        {
            MsgBox ,,, this file would be deleted - %LogFile%
        }        
    }
}
Return

@echo off
set OUTPUT_FILE="%~n1_krnmap.txt"
%~p0%~n0.exe %1 > %OUTPUT_FILE%
type %OUTPUT_FILE%
pause

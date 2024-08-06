@echo off
set OUTPUT_FILE="%~n1.html"
%~p0%~n0.exe %1 > %OUTPUT_FILE%

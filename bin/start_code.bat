@echo off
set OSS_CAD_SUITE_WORK=%HOMEPATH%\source\repos\LogicDesign

cd %OSS_CAD_SUITE_WORK%
call "%~dp0\environment.bat" 
start /b code %OSS_CAD_SUITE_WORK%
exit
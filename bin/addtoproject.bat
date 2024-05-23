@echo off
@REM addtoproject.bat - ファイルをプロジェクトに登録する。

@REM 引数のチェック
if "%2" == "" (
    echo %~n0 file-name project-name
    exit 1
)

set PROJECT_FILE=%2.qsf
set FILE_NAME=%1
set EXTENSION=%~x1

echo %EXTENSION%

@REM ファイルの存在チェック
if not exist %PROJECT_FILE% (
    echo No project file: %PROJECT_FILE%
    exit 1
)

if not exist %FILE_NAME% (
    echo No source file: %FILE_NAME%
    exit 1
)

@REM 登録済みかどうかの確認
if "%EXTENSION%" == ".vhd" (  
    set ENTRY="set_global_assignment -name VHDL_FILE %FILE_NAME%"
) else if "%EXTENSION%" == ".v" (
    set ENTRY="set_global_assignment -name VERILOG_FILE %FILE_NAME%"
) else if "%EXTENSION%" == ".sv" (
    set ENTRY="set_global_assignment -name SYSTEMVERILOG_FILE %FILE_NAME%"
) else (
    echo Unsupported file: %FILE_NAME%
    exit 1
)

findstr /C:%ENTRY% %PROJECT_FILE% > NUL
if not %ERRORLEVEL% == 0 (
    @REM 登録
    echo %ENTRY:~1,-1% >> %PROJECT_FILE%
)

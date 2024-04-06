@echo off
@REM removefromproject.bat - ファイルをプロジェクトから削除する。

@REM 引数のチェック
if "%2" == "" (
    echo %~n0 file-name project-name
    exit 1
)

set PROJECT_FILE=%2.qsf
set FILE_NAME=%1

@REM ファイルの存在チェック
if not exist %PROJECT_FILE% (
    echo No project file: %PROJECT_FILE%
    exit 1
)

@REM 登録済みかどうかの確認
set ENTRY="set_global_assignment -name VHDL_FILE %FILE_NAME%"

findstr /C:%ENTRY% %PROJECT_FILE% > NUL
if %ERRORLEVEL% == 0 (
    @REM 削除
    rename %PROJECT_FILE% %PROJECT_FILE%.old
    findstr /V /C:%ENTRY% %PROJECT_FILE%.old > %PROJECT_FILE%
)

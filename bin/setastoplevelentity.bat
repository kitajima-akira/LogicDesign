@echo off
@REM setAsTopLevelEntity.bat - ファイルをトップレベルエンティティとしてプロジェクトに登録する。
@REM Author: Kitajima Akira kitajima@osakac.ac.jp

@REM 引数のチェック
if "%2" == "" (
    echo %~dp0 %~n0 file-name project-name
    exit 1
)

set FILE_NAME=%1
set FILE_BASE_NAME=%~n1
set FILE_DIR_NAME=%~dp1
set PROJECT_NAME=%2
set PROJECT_FILE=%FILE_DIR_NAME%%PROJECT_NAME%.qsf

@REM ファイルの存在チェック
if not exist %PROJECT_FILE% (
    echo No project file: %PROJECT_FILE%
    exit 1
)

if not exist %FILE_NAME% (
    echo No source file: %FILE_NAME%
    exit 1
)

if not "%~x1" == ".vhd" (
    echo not a VHDL file: %FILE_NAME%
    exit 1
)

@REM ENTRY1が登録済みかどうかの確認
set ENTRY1="set_global_assignment -name VHDL_FILE %FILE_NAME%"

findstr /C:%ENTRY1% %PROJECT_FILE% > NUL
if not %ERRORLEVEL% == 0 (
    @REM ENTRY1を登録
    echo %ENTRY1:~1,-1% >> %PROJECT_FILE%
)

@REM ENTRY2が登録済みかどうかの確認
set ENTRY2="set_global_assignment -name TOP_LEVEL_ENTITY %FILE_BASE_NAME%"

findstr /C:%ENTRY2% %PROJECT_FILE% > NUL
if not %ERRORLEVEL% == 0 (
    setlocal enabledelayedexpansion
    @REM ENTRY2は登録されていないので登録する。

    @REM 別のファイルが登録されているか確認する。
    set ENTRY="set_global_assignment -name TOP_LEVEL_ENTITY"

    findstr /C:!ENTRY! %PROJECT_FILE% > NUL
    if !ERRORLEVEL! == 0 (
        echo remove previous top level entity
        @REM 登録を削除する。
        if exist %FILE_DIR_NAME%%PROJECT_NAME%.bak (del %FILE_DIR_NAME%%PROJECT_NAME%.bak)
        rename %PROJECT_FILE% *.bak
        findstr /V /C:!ENTRY! %FILE_DIR_NAME%%PROJECT_NAME%.bak > %PROJECT_FILE%
    )

    @REM ENTRY2を登録する。
    echo add new top level entity %FILE_BASE_NAME%
    echo %ENTRY2:~1,-1% >> %PROJECT_FILE%
    endlocal
)

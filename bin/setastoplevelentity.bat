@echo off
@REM setAsTopLevelEntity.bat - ファイルをトップレベルエンティティとしてプロジェクトに登録する。
@REM Author: Kitajima Akira kitajima@osakac.ac.jp

@REM 引数のチェック
if "%2" == "" (
    echo %~n0 file-name project-name
    exit /b 1
)

set FILE_NAME=%1
set FILE_BASE_NAME=%~n1
set FILE_DIR_NAME=%~dp1
set PROJECT_NAME=%2
set PROJECT_FILE=%FILE_DIR_NAME%%PROJECT_NAME%.qsf

@REM ファイルの存在チェック
if not exist %PROJECT_FILE% (
    echo No project file: %PROJECT_FILE%
    exit /b 1
)

if not exist %FILE_NAME% (
    echo No source file: %FILE_NAME%
    exit /b 1
)

@REM 対応する拡張子かチェック
if "%~x1" == ".vhd" (
    rem do nothing
) else if "%~x1" == ".v" (
    rem do nothing
) else if "%~x1" == ".sv" (
    rem do nothing
) else (
    echo Unsupported file: %FILE_NAME%
    exit /b 1
)

@REM プロジェクトファイルのクリーナップ (存在するファイルだけ用いる)
call :CLEANUP_PROJECT VHDL_FILE .vhd
call :CLEANUP_PROJECT VERILOG_FILE .v
call :CLEANUP_PROJECT SYSTEMVERILOG_FILE .sv

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
exit /b 0

@REM =========================================================
:CLEANUP_PROJECT
@REM %1 ファイルタイプの文字列
@REM %2 拡張子 
@REM プロジェクトファイルから不要なエントリ(存在しないファイル)を削除する。

@REM System Verilogファイルのクリーナップ (存在するファイルだけ用いる)
set FILE_ENTRY="set_global_assignment -name %1"
set TMPFILE=%FILE_DIR_NAME%%PROJECT_NAME%.tmp
findstr /V /C:%FILE_ENTRY% %PROJECT_FILE% > %TMPFILE%
@REM 削除されたエントリがあればプロジェクトファイルを更新する。
fc %PROJECT_FILE% %TMPFILE% > NUL
if %ERRORLEVEL% == 0 (
    del %TMPFILE
) else (
    del %PROJECT_FILE%
    rename %TMPFILE% *.qsf
)

if exist *%2 (
    for %%f in (*%2) DO (
        echo set_global_assignment -name %1 %%f >> %PROJECT_FILE%
    )
)
exit /b

@echo off
@REM setAsTopLevelEntity.bat - ファイルをトップレベルエンティティとしてプロジェクトに登録する。
@REM Author: Kitajima Akira kitajima@osakac.ac.jp

@REM 引数のチェック
if "%2" == "" (
    echo %~n0 file-name project-name
    exit /b 1
)

set "IMPORT_FILE=import.txt"
set "ROOT_DIR=%CD%\"
set "FILE=%1"
set "FILE_BASE=%~n1"
set "FILE_DIR=%~dp1"
set "PROJECT=%2"
set "PROJECT_FILE=%FILE_DIR%%PROJECT%.qsf"

@REM ROOTディレクトリとは異なるディレクトリの場合、プロジェクトファイルを対象ディレクトリへコピーする。
if not %ROOT_DIR% == %FILE_DIR% (
    copy /y %ROOT_DIR%%PROJECT%.qsf %PROJECT_FILE% > NUL
    copy /y %ROOT_DIR%%PROJECT%.qpf %FILE_DIR%%PROJECT%.qpf > NUL
    copy /y %ROOT_DIR%%PROJECT%.sdc %FILE_DIR%%PROJECT%.sdc > NUL
) 

@REM ファイルの存在チェック
if not exist %PROJECT_FILE% (
    echo No project file: %PROJECT_FILE%
    exit /b 1
)

if not exist %FILE% (
    echo No source file: %FILE%
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
    echo Unsupported file: %FILE%
    exit /b 1
)

echo target directory: %FILE_DIR%
@REM FILE_DIRを起点として、親となるROOT_DIRの相対パスを求める。
set RELATIVE_ROOT=
setlocal enabledelayedexpansion
set RELATIVE=
set "TEMP_DIR=!FILE_DIR!"
if not "!TEMP_DIR:~-1!"=="\" set "TEMP_DIR=!TEMP_DIR!\"

@REM TEMP_DIRの階層を一つずつ上がっていく。
:SET_RELATIVE_PATH
    if "!TEMP_DIR!"=="!ROOT_DIR!" (
        @REM ROOT_DIRに辿りついた。
        goto :END_RELATIVE_PATH
    )
    set "RELATIVE=..\\!RELATIVE!"
    set PREV_TEMP=!TEMP_DIR!
    for %%A in ("!TEMP_DIR!..") do set "TEMP_DIR=%%~fA\"
    if "!PREV_TEMP!" == "!TEMP_DIR!" (
        @REM ROOT_DIRが見つからなかった。
        set "RELATIVE=!ROOT_DIR!" 
        goto :END_RELATIVE_PATH
    )
    goto :SET_RELATIVE_PATH
:END_RELATIVE_PATH
endlocal & set "RELATIVE_ROOT=%RELATIVE%"

@REM echo root from current: %RELATIVE_ROOT%

cd %FILE_DIR%

@REM プロジェクトファイルのクリーナップ (存在するファイルだけ用いる)
call :CLEANUP_PROJECT VHDL_FILE .vhd %RELATIVE_ROOT%
call :CLEANUP_PROJECT VERILOG_FILE .v %RELATIVE_ROOT%
call :CLEANUP_PROJECT SYSTEMVERILOG_FILE .sv %RELATIVE_ROOT%

if not %ROOT_DIR% == %FILE_DIR% (
    @REM ターゲットディレクトリのファイルを追加する。
    call :ADD_ALL VHDL_FILE .vhd
    call :ADD_ALL VERILOG_FILE .v
    call :ADD_ALL SYSTEMVERILOG_FILE .sv
) 

@REM ENTRY2が登録済みかどうかの確認
set "ENTRY=set_global_assignment -name TOP_LEVEL_ENTITY"
set "ENTRY2=%ENTRY% %FILE_BASE%"

findstr /C:"%ENTRY2%\>" "%PROJECT_FILE%" > NUL
if not %ERRORLEVEL% == 0 (
    setlocal enabledelayedexpansion
    @REM ENTRY2は登録されていないので登録する。

    @REM 別のファイルが登録されているか確認する。
    findstr /C:"!ENTRY!" "%PROJECT_FILE%" > NUL
    if !ERRORLEVEL! == 0 (
        echo remove previous top level entity
        @REM 登録を削除する。
        set "BACKUP_FILE=%FILE_DIR%%PROJECT%.bak"
        if exist !BACKUP_FILE! (del !BACKUP_FILE!)
        rename %PROJECT_FILE% *.bak
        findstr /V /C:"!ENTRY!" "!BACKUP_FILE!" > %PROJECT_FILE%
    )

    @REM ENTRY2を登録する。
    echo add new top level entity %FILE_BASE%
    echo !ENTRY2!>> %PROJECT_FILE%
    endlocal
)

cd %ROOT_DIR%

exit /b 0
@REM END of the script

@REM =========================================================
:CLEANUP_PROJECT
@REM %1 ファイルタイプの文字列
@REM %2 拡張子 
@REM %3 LogicDesignルートの相対位置
@REM プロジェクトファイルから不要なエントリ(存在しないファイル)を削除する。

@REM プロジェクトファイルのクリーナップ (存在するファイルだけ用いる)
set FILE_ENTRY="set_global_assignment -name %1"
set TMPFILE=%FILE_DIR%%PROJECT%.tmp
findstr /V /C:%FILE_ENTRY% %PROJECT_FILE% > %TMPFILE%
@REM 削除されたエントリがあればプロジェクトファイルを更新する。
fc %PROJECT_FILE% %TMPFILE% > NUL
if %ERRORLEVEL% == 0 (
    del %TMPFILE%
) else (
    del %PROJECT_FILE%
    rename %TMPFILE% *.qsf
)

@REM 存在するファイルを登録する。
:ADD_ALL
if exist "%3*%2" (
    @REM tb_で始まったり _tbで終わる名前は除外する。
    for /f %%f in ('dir /B %3*%2 ^| findstr /V "^tb_" ^| findstr /V "_tb%2$"') do (
        echo set_global_assignment -name %1 %3%%f>> %PROJECT_FILE%
    )
)

@REM IMPORT_FILEのファイルを登録する。
set "REGEXP=\%2$"
if exist %3%IMPORT_FILE% (
    for /f %%f in ('type %3%IMPORT_FILE% ^| findstr %REGEXP%') do (
        setlocal enabledelayedexpansion
        set "TARGET_FILE=%%f"
        echo set_global_assignment -name %1 %3!TARGET_FILE:\=\\!>> %PROJECT_FILE%
        endlocal
    )
)

exit /b
@REM END of CLEANUP_PROJECT, ADD_ALL

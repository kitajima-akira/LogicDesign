# makeSimulationScript.ps1 - Questaシミュレーションスクリプトを生成する。
# Author: Kitajima Akira kitajima@osakac.ac.jp
#
# (参考) Powershellのスクリプトは実行できないよう設定されている。
# それを解除するには、Powershellを管理者で起動し、次のコマンドを入力 (1回やればよい)
# Set-ExecutionPolicy RemoteSigned

# 引数のチェック
param (
    [Parameter(Mandatory)]
    [String]$filename,
    [Parameter(Mandatory)]
    [String]$projectName
)

$PSDefaultParameterValues['Out-File:Encoding'] = 'ascii'

$directoryName = Split-Path -Path $fileName
$projectFileName = $projectName + ".qsf"
if ($directoryName) {
    $projectFileName = $directoryName + "\" + $projectFileName
}

# ファイルの存在チェック
if (-not(Test-Path $projectFileName)) {
    Write-Output "No project file: $projectFileName"
    Exit-PSSession
}

if (-not(Test-Path $fileName)) {
    Write-Output "No source file: $fileName"
    Exit-PSSession
}

$simulationDirectory = "simulation\questa"
if ($directoryName) {
    $simulationDirectory = $directoryName + "\" + $simulationDirectory
}
if (-not(Test-Path $simulationDirectory)) {
    Write-Output "No simulation folder: $simulationDirectory"
    Exit-PSSession
}

$scriptName = $simulationDirectory + "\run_" + $projectName + ".do"

# 出力開始 #########################

Write-output @"
transcript on
if {[file exists rtl_work]} {
    vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

"@ > $scriptName

# プロジェクトのファイルはすべて追加する。
Select-String -path $projectFileName "VHDL_FILE" `
    | ForEach-Object -Process { $_ -replace "^.+VHDL_FILE (?<filename>[\w_.]+).*$", `
                                    "vcom -93 -work work {$directoryName\`${filename}}"} >> $scriptName

$baseName = (Split-Path -Leaf $fileName) -replace "(?<basename>).vhd", '${basename}'

Write-output @"
vcom -93 -work work {$simulationDirectory\tb_$baseName.vhd}

vsim -t 1ns -L rtl_work -L work -voptargs="+acc"  TB_$baseName
add wave sim:/tb_$baseName/DUV/*
view structure
view signals
run
"@ >> $scriptName

# ivsim.ps1 - Icarus Verilogでシミュレーションを実行する。

# 引数のチェック
param (
    [Parameter(Mandatory)]
    [String]$fileName,
    [Parameter]
    [String]$testBenchPath
)

# テストベンチパス省略時
$tbPath
if ($testBenchPath) {
    $tbPath = $testBenchPath
} else {
    $tbPath = "simulation\systemVerilog"  
}

$PSDefaultParameterValues['Out-File:Encoding'] = 'ascii'

# 元のファイルのディレクトリ
$directoryName = Split-Path -Path $fileName
# テスト対象モジュールの名前
$moduleName = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
# テストベンチモジュールの名前
$testBenchName = "${moduleName}_tb"
# テストベンチのファイル名
$testBenchFileName = "$directoryName\$tbPath\$testBenchName.sv"
# コンパイルされたデータ (Icarus Verilog)
$compiledOutput = "$moduleName.out"

# ファイルの存在チェック
if (-not(Test-Path $fileName)) {
    Write-Output "No input file: $fileName"
    Exit-PSSession
}

if (-not(Test-Path $testBenchFileName)) {
    Write-Output "No test bench file: $testBenchFileName"
    Exit-PSSession
}

# シミュレーションの実行
iverilog -g 2012 -o $compiledOutput -s $testbenchName -Y .sv -y . $fileName $testBenchFileName
if ($?) {
    vvp $compiledOutput
    Remove-Item $compiledOutput    
}
if (Test-Path 'a.out') {
    Remove-Item 'a.out'
}

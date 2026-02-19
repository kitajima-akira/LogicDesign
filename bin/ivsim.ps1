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
# 元ファイルの拡張子
$extension = [System.IO.Path]::GetExtension($fileName)
# テスト対象モジュールの名前
$moduleName = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
# テストベンチのモジュール名(_tb)の場合は元のモジュール名に戻す。
if ( $moduleName -match '_tb$' ) {
    $moduleName = $moduleName -replace "_tb$", ''
    $fileName = "$moduleName$extension"
    $directoryName = "."
}
# テストベンチモジュールの名前
$testBenchName = "${moduleName}_tb"
# テストベンチのファイル名
$testBenchFileName = "$testBenchName$extension"
# テストベンチの既定ディレクトリ名
$defaultTestBenchDirectoryName = "$directoryName\$tbPath"
# コンパイルされたデータ (Icarus Verilog)
$compiledOutput = "$moduleName.out"

# ファイルの存在チェック
if (-not(Test-Path $fileName)) {
    Write-Output "No input file: $fileName"
    Exit-PSSession
}

if (-not(Test-Path (Join-Path $directoryName $testBenchFileName))) {
    $testBenchFileName = Join-Path $defaultTestBenchDirectoryName $testBenchFileName
    if (-not(Test-Path $testBenchFileName)) {
        Write-Output "No test bench file: $testBenchFileName; use $fileName"
        # テストベンチ用ファイルがなくても元のファイルに書くこともできるので、ファイルなしで進める。
        $testBenchFileName = ''
    }
} else {
    $testBenchFileName = Join-Path $directoryName $testBenchFileName
}

# シミュレーションの実行
Write-Output "iverilog -g 2012 -o $compiledOutput -s $testbenchName -Y $extension -y . $fileName $testBenchFileName"
iverilog -g 2012 -o $compiledOutput -s $testbenchName -Y $extension -y . $fileName $testBenchFileName
if ($?) {
    vvp $compiledOutput
    Remove-Item $compiledOutput    
}

# 不要なa.outファイルを削除
$AOutFileName = Join-Path $directoryName 'a.out'
if (Test-Path $AOutFileName) {
    Remove-Item $AOutFileName
}

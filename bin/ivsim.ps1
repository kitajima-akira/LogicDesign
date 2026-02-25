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
$defaultTestBenchDirectoryName = "$tbPath"
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
        $testBenchFileName = $null
    }
} else {
    $testBenchFileName = Join-Path $directoryName $testBenchFileName
}

# シミュレーションの実行 ########

# まず必要な引数(明示的に指定が必要なファイル)をリストアップする。

# 現ディレクトリからの相対パス名に変換する。
function ConvertTo-RelativePathName ($name) {
    (Resolve-Path -Path $name -Relative) -replace "^\.\\", ""  
}

$fileName = ConvertTo-RelativePathName $fileName
$testBenchFileName = ConvertTo-RelativePathName $testBenchFileName
$targetFiles = if ($testBenchFileName) {@($fileName, $testBenchFileName)} else {@($fileName)}

# インポートファイルを読み込み配列に格納する。
function Read-ImportFile ($directory, $file, $files) {
    $targetFiles = @()
    $importFileName = Join-Path $directory $file
    if (Test-Path $importFileName) {
        $importFiles = (Get-Content $importFileName) -split "\n"
        foreach ($fileName in $importFiles) {
            $fileName = ConvertTo-RelativePathName (Join-Path $directory $fileName)
            if (-not($files -contains $fileName)) {
                $targetFiles += $fileName
            }
        }
    }
    $targetFiles
}

$targetFiles += Read-ImportFile $directoryName "import.txt" $targetFiles
$targetFiles += Read-ImportFile $PWD "import.txt" $targetFiles
$targetFiles = foreach ($i in $targetFiles) {(Resolve-Path -Path $i -Relative) -replace "^\.\\", ""}

$includeDirectories = if ($directoryName -eq $PWD) {"-y ."} else {"-y . -y " + (Resolve-Path -Path $directoryName -Relative)}

# シミュレーションを実行する。
Write-Output "iverilog -g 2012 -o $compiledOutput -s $testbenchName -Y $extension $includeDirectories $targetFiles"
powershell iverilog -g 2012 -o $compiledOutput -s $testbenchName -Y $extension $includeDirectories $targetFiles
if (Test-Path $compiledOutput) {
    vvp $compiledOutput
    Remove-Item $compiledOutput    
}

# 不要なa.outファイルを削除する。
$AOutFileName = Join-Path $directoryName 'a.out'
if (Test-Path $AOutFileName) {
    Remove-Item $AOutFileName
}

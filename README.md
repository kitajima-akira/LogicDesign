# LogicDesign

LogicDesignはWindows環境での初学者向きのディジタル回路設計ワークスペースです。
大阪電気通信大学総合情報学部情報学科の「論理回路」および「論理設計演習」で用いています。

## インストール・設定

### gitコマンド

gitコマンドがインストールされていない場合はインストールしてください。
インストールされているかどうかは以下のようにターミナルで入力してください。

    git -v

gitコマンドがインストールされていない場合は、[Gitのインストール方法(Windows版)](https://qiita.com/T-H9703EnAc/items/4fbe6593d42f9a844b1c) など外部サイトを参照してインストールしてください。

### LogicDesignパッケージのインストール

GitHubを使用している(アカウントを持っている)場合、LogicDesignのリポジトリをコピーしてから使用するといいでしょう。
その場合は[テンプレートからリポジトリを作成する](https://docs.github.com/ja/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template)を見てください。

LogicDesignは演習のワークスペース(作業フォルダ)になります。
LogicDesignの置き場所はC:\Users\学生番号\source\reposにしてください。
他のフォルダにすると問題が起こる場合があります。

エクスプローラーで C:\Users\学生番号\source\repos を開いて、アドレスバーにpowershellと入力することで、Powershellのターミナルが開きます。
そこに以下を入力してください。(自分のレポジトリにコピーした場合はそこを指定します。)

    git clone https://github.com/kitajima-akira/LogicDesign.git

### 実行のための設定

LogicDesignではPowerShellスクリプトの実行を有効にする必要があります。

ターミナルを管理者で開いて、以下を実行してください。
ターミナルを管理者で開くには、Windowsのタククバーのスタートボタンを右クリックして「ターミナル(管理者)」を選びます。
この際、設定によってはWindows Powershellではなくコマンドプロンプトになっていることがあります。
その場合はコマンドプロンプトにpowershellと入力してから以下を実行してください。

    Set-ExecutionPolicy RemoteSigned

### OSS CAD Suiteとの連携

OSS CAD Suiteと連携するために、Visual Studio Codeを起動するときには、OSS CAD Suiteのstart.batを起動して表示されるターミナルに「code」と入力して起動する必要があります。次の設定を行うと、タスクバーのアイコンをクリックするだけでVisual Studio Codeを起動できます。

1. LogicDesign\bin\start_code.batをOSS CAD Suiteのstart.batがあるフォルダにコピーする。
2. コピーしたstart_code.batをWindowsのエクスプローラーで右クリック > その他のオプションを確認 > ショートカットの作成
3. 作成されたショートカットを右クリック > その他のオプションを確認 > プロパティ
4. 表示された「start_code.bat - ショートコットのプロパティ」のウィンドウの「リンク先」の部分について、元から入力されている文字列は消さずに、先頭に「explorer 」(末尾は空白文字)を追加する。
5. 「アイコンの変更」ボタンを押し、「参照」からC:\Program Files\Microsoft VS CodeのCode.exeを選択し「開く」とし、アイコンを選んで「OK」
6. プロパティのウィンドウの「OK」を押す。
7. 「start_code.bat - ショートカット」をドラッグし、タスクバーにドロップする。

### Visual Studio Codeの設定

#### 拡張機能TerosHDLのインストールと設定
1. Visual Studio Codeを起動し、画面左側の縦に並んでいるアイコンから「拡張機能」(マウスカーソルをアイコンに重ねたら表示されます)をクリックします。

1. 押したアイコンの右横エリアの上部にある「Marketplaceで拡張機能を検索する」の部分に「TerosHDL」と入力します。

1. 「TerosHDL」のインストールを押します。

1. 左側の縦に並んでいるアイコンの中にあるTerosHDLのアイコンをクリックします。

1. 下の方にスクロールしていき、「CONFIGURATION」の中の「Open Global Settings Menu」をクリックします。

1. 「Linter settings」をクリックしてVerilog/SV linterの部分で「Icarus」を選択します。

1. 左側の「Icarus linter」をクリックしてArgumentsの部分に「-g 2012 -Y .sv -y . -y ..\\..」と入力します。

1. 左側の「Schematic viewer」をクリックしてSelect the backendの部分で「YoWASP (Only Verilog/SV)」を選択します。

1. 画面下にある「Apply and close」ボタンを押します。

#### 拡張機能VaporViewのインストールと設定
1. Visual Studio Codeの画面左側の縦に並んでいるアイコンから「拡張機能」をクリックします。

1. 押したアイコンの右横エリアの上部にある「Marketplaceで拡張機能を検索する」の部分に「VaporView」と入力します。

1. 「VaporView」のインストールを押します。

#### おすすめのVisual Studio Codeフォント設定 (任意)
この設定は必ず行わないといけないわけではありませんが、おすすめの設定ですので、内容を理解して、設定してもよいと思ったら是非行ってください。
フォントにより見やすさがかなり変わりますので、適切に設定するとコーディング(プログラムを考えて入力する作業)の効率も上がります。

##### 標準のフォントのみ使用する設定
Visual Studio Codeの画面左下にある歯車アイコン(設定)>設定で、次のように設定します。
 - Editor: Font Family ⇒ Consolas, ‘BIZ UDゴシック’, monospace
 - Terminal > Integrated: Font Family ⇒ ‘BIZ UDゴシック’, monospace

##### フォントをインストールして使用する設定
よりよいフォントを見つけて設定することもできます。[Visual Studio Codeで使用するフォントを自分でインストールし使用するには](doc/additional_font.md)

## LogicDesignの機能

### 7セグメントLED表示シミュレーション
HDLシミュレーションにより決まったフォーマットのデータを生成することで、7セグメントLEDでどのように表示されるのかブラウザで確認できます。

[disp7seg](disp7seg/disp7seg.html)

### カルノー図表示
HDLシミュレーションにより決まったフォーマットのデータを生成することで、作成した回路の出力をカルノー図としてブラウザで確認できます。

[karnaughmap](karnaughmap/karnaughmap.html)

### FPGAボードの利用
LogicDesignでは[Terasic社のFPGAボードDE10-lite](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=234&No=1021)を使って簡単に動作が確認できます。

[FPGAボードの使い方チュートリアル](doc/board_tutorial.md)

### LogicDesignの更新
Visual Studio CodeでLogicDesignを開き、タスクの実行 > LogicDesign: Updateを実行することで最新版に更新することができます。

また、ターミナルを開き以下のコマンドを実行することでも、最近のLogicDesignに更新することができます。

    git fetch origin
    git reset --hard origin/main

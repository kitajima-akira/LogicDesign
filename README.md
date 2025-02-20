# LogicDesign

大阪電気通信大学総合情報学部情報学科の「論理回路」および「論理設計演習」で用います。

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

## Visual Studio Codeの設定

### 拡張機能のインストールと設定
1. Visual Studio Codeを起動し、画面左側の縦に並んでいるアイコンから「拡張機能」(マウスカーソルをアイコンに重ねたら表示されます)をクリックします。

1. 押したアイコンの右横エリアの上部にある「Marketplaceで拡張機能を検索する」の部分に「TerosHDL」と入力します。

1. 「TerosHDL」のインストールを押します。

1. 左側の縦に並んでいるアイコンの中にあるTerosHDLのアイコンをクリックします。

1. 下の方にスクロールしていき、「CONFIGURATION」の中の「Open Global Settings Menu」をクリックします。

1. 「Linter settings」をクリックしてVerilog/SV linterの部分で「Icarus」を選択します。

1. 左側の「Icarus linter」をクリックしてArgumentsの部分に「-g 2012 -Y .sv -y . -y ..\\..」と入力します。

1. 左側の「Schematic viewer」をクリックしてSelect the backendの部分で「YoWASP (Only Verilog/SV)」を選択します。

1. 画面下にある「Apply and close」ボタンを押します。

### おすすめのVisual Studio Codeフォント設定 (任意)
この設定は必ず行わないといけないわけではありませんが、おすすめの設定ですので、内容を理解して、設定してもよいと思ったら是非行ってください。
フォントにより見やすさがかなり変わりますので、適切に設定するとコーディング(プログラムを考えて入力する作業)の効率も上がります。

#### 標準のフォントのみ使用する設定
Visual Studio Codeの画面左下にある歯車アイコン(設定)>設定で、次のように設定します。
 - Editor: Font Family ⇒ Consolas, ‘BIZ UDゴシック’, monospace
 - Terminal > Integrated: Font Family ⇒ ‘BIZ UDゴシック’, monospace

#### フォントをインストールして使用する設定
自分でフォントをインストールし、前節と同じ項目を変更します。
 - Editor: Font Family ⇒ Consolas, ‘BIZ UDゴシック’, monospace

Consolasの部分を使いたいフォント名に変えます。名前の途中にスペースがある場合は’(シングルクォーテーション)で囲みます。
- Terminal > Integrated: Font Family ⇒ ‘BIZ UDゴシック’, monospace

‘BIZ UDゴシック’の前にフォント名を追加します。

コーディング作業に向いたフォントが多数考案されています。インストール方法は各サイトに書かれてある説明を見てください。基本的には、フォントファイルの.ttfをクリックして、フォント見本表示の右上の「インストール」を押せばWindows環境にインストールされ使用できるようになります。

Visual Studio Codeの場合は、フォントをインストールしたら、Visual Studio Codeも再起動しないと、設定を変更しただけでは正しく反映されない(新しいフォントに変わらない)ので注意してください。

英数字のフォントは、以下のサイトを使用すると自分の好きなのが見つかりやすいでしょう。

- [Coding Font](https://www.codingfont.com/)
  - 英語のサイトですが、有名なコーディング用フォントを2種類ずつ比較して、トーナメント形式で自分の好きなのを選ぶことができます。
- [Cascadia Code](https://github.com/microsoft/cascadia-code)
  - Microsoftの最新のコーディング用フォントです。日本語対応も進められています。[Cascadia Next](https://github.com/microsoft/cascadia-code/releases/tag/cascadia-next)

日本語の文字も含めたフォントもあります。
- [プログラミングフォント 白源 (はくげん／HackGen)](https://github.com/yuru7/HackGen)
- [yuru7](https://github.com/yuru7?tab=repositories)
- [M+ FONTS | JAPANESE](https://mplusfonts.github.io/)
- [フリーフォント (自家製フォント工房)](http://jikasei.me/font/#google_vignette)
- [GitHub - edihbrandon/RictyDiminished: Ricty Diminished --- fonts for programming](https://github.com/edihbrandon/RictyDiminished)
- [GitHub - miiton/Cica: プログラミング用日本語等幅フォント Cica(シカ)](https://github.com/miiton/Cica)
- [プログラミングフォント Myrica](https://myrica.estable.jp/)
- [Miguフォント](https://itouhiro.github.io/mixfont-mplus-ipa/migu/)
- [源暎フォント置き場 - 御琥祢屋](https://okoneya.jp/font/)

私は以下のフォントを使用しています。(授業での表示)
- プログラム編集
  - 'Roboto Mono' [Roboto Mono - Google Fonts](https://fonts.google.com/specimen/Roboto+Mono)
- ターミナル (実行結果等)
  - '源暎モノコード' [【フリーフォント】源暎モノゴ/モノコード - 御琥祢屋](https://okoneya.jp/font/genei-mono-go.html)

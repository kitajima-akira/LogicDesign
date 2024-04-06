# LogicDesign

大阪電気通信大学総合情報学部情報学科の「論理回路」および「論理設計演習」で用います。

## インストール・設定

### gitコマンド

gitコマンドがインストールされていない場合はインストールしてください。
インストールされているかどうかは以下のようにターミナルで入力してください。

    git -v

gitコマンドがインストールされていない場合は、[Gitのインストール方法(Windows版)](https://qiita.com/T-H9703EnAc/items/4fbe6593d42f9a844b1c) など外部サイトを参照してインストールしてください。

### LogicDesignパッケージのインストール

これは演習の作業フォルダになります。
LogicDesignの置き場所はC:\Users\学生番号\source\reposにしてください。
他のフォルダにすると問題が起こる場合があります。

エクスプローラーで C:\Users\学生番号\source\repos を開いて、アドレスバーにpowershellと入力することで、Powershellのターミナルが開きます。
そこに以下を入力してください。

    git clone https://github.com/kitajima-akira/LogicDesign.git


### 実行のための設定

LogicDesignではPowerShellスクリプトの実行を有効にする必要があります。

ターミナルを管理者で開いて、以下を実行してください。

    Set-ExecutionPolicy RemoteSigned

## Visual Studio Codeの設定

### 拡張機能のインストール
1. Visual Studio Codeを起動し、画面左側の縦に並んでいるアイコンから「拡張機能」(マウスカーソルをアイコンに重ねたら表示されます)をクリックします。

1. 押したアイコンの右横エリアの上部にある「Marketplaceで拡張機能を検索する」の部分に「vhdl」と入力します。

1. 「VHDL Formatter」と「VHDL by VHDLwhiz」のインストールを押します。

1. Visual Studio Codeの画面左下にある歯車アイコン(設定)>設定で、上の設定の検索のところにvhdlと入力します。

1. 次のとおり設定してください。
 - Vhdl > Formatter > Case: Keyword  ⇒ LowerCase
 - Vhdl > Formatter > Case: Typename ⇒ LowerCase
 - Vhdl > Formatter: Instert Final Newline ⇒ チェック[✓]を入れる

### おすすめのVisual Studio Codeフォント設定 (任意)
この設定は必ず行わないといけないわけではありませんが、おすすめの設定ですので、内容を理解して、設定してもよいと思ったら是非行ってください。
フォントにより見やすさがかなり変わりますので、適切に設定するとコーディング(プログラムを考えて入力する作業)の効率も上がります。

#### 標準のフォントのみ使用する設定
Visual Studio Codeの画面左下にある歯車アイコン(設定)>設定で、上の設定の検索のところにvhdlと入力します。
次のように設定します。
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

日本語の文字も含めたフォントもあります。
- [M+ FONTS | JAPANESE](https://mplusfonts.github.io/)
- [フリーフォント](http://jikasei.me/font/#google_vignette)
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

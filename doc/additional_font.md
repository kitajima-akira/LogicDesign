# Visual Studio Codeで使用するフォントを自分でインストールし使用するには

## フォントの選択

コーディング作業に向いたフォントが多数考案されています。インストール方法は各サイトに書かれてある説明を見てください。基本的には、フォントファイルの.ttfをクリックして、フォント見本表示の右上の「インストール」を押せばWindows環境にインストールされ使用できるようになります。

英数字のフォントは、以下のサイトを使用すると自分の好きなのが見つかりやすいでしょう。

- [Coding Font](https://www.codingfont.com/)
  - 英語のサイトですが、有名なコーディング用フォントを2種類ずつ比較して、トーナメント形式で自分の好きなのを選ぶことができます。
- [Cascadia Code](https://github.com/microsoft/cascadia-code)
  - Microsoftの最新のコーディング用フォントです。日本語対応も進められています。[Cascadia Next](https://github.com/microsoft/cascadia-code/releases/tag/cascadia-next)

日本語の文字も含めたフォントもあります。
- [yuru7](https://github.com/yuru7?tab=repositories)
  - 様々なフォントを公開しています。各リポジトリを見てください。
- [M+ FONTS | JAPANESE](https://mplusfonts.github.io/)
- [フリーフォント (自家製フォント工房)](http://jikasei.me/font/#google_vignette)
- [GitHub - edihbrandon/RictyDiminished: Ricty Diminished --- fonts for programming](https://github.com/edihbrandon/RictyDiminished)
- [GitHub - miiton/Cica: プログラミング用日本語等幅フォント Cica(シカ)](https://github.com/miiton/Cica)
- [プログラミングフォント Myrica](https://myrica.estable.jp/)
- [Miguフォント](https://itouhiro.github.io/mixfont-mplus-ipa/migu/)
- [源暎フォント置き場 - 御琥祢屋](https://okoneya.jp/font/)
- [プログラミング向きの日本語フォント集](https://zenn.dev/omonomo/articles/0ee3b1a8332c52)

私は以下のフォントを使用しています。(授業での表示)
- プログラム編集
  - 'Roboto Mono' [Roboto Mono - Google Fonts](https://fonts.google.com/specimen/Roboto+Mono)
- ターミナル (実行結果等)
  - '源暎モノコード' [【フリーフォント】源暎モノゴ/モノコード - 御琥祢屋](https://okoneya.jp/font/genei-mono-go.html)

## フォントの設定
自分でフォントをインストールした後に、Visual Studio Codeの画面左下にある歯車アイコン(設定)>設定で、次のように設定します。
 - Editor: Font Family ⇒ Consolas, ‘BIZ UDゴシック’, monospace

上記のConsolasの部分を使いたいフォント名に変えます。名前の途中にスペースがある場合は’(シングルクォーテーション)で囲みます。

- Terminal > Integrated: Font Family ⇒ ‘BIZ UDゴシック’, monospace

‘BIZ UDゴシック’の前にフォント名を追加します。

Visual Studio Codeでは、新しくフォントをインストールしたら、Visual Studio Codeを再起動しないと、設定を変更してもすぐには反映されない(新しいフォントに変わらない)ので注意してください。

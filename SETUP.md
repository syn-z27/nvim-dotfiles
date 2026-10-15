# セットアップガイド

Ubuntu / macOS / Windows (Git Bash + Windows Terminal) で同じ設定を使えます。
OS ごとの差分は設定内で `vim.fn.has("win32")` により分岐しています。

## 必要条件

| ツール | 用途 | Windows |
|---|---|---|
| Neovim >= 0.12 | 本体 | ○ |
| Git | lazy.nvim / プラグインのインストール | ○ |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | any-jump.vim、Telescope のgrep検索 | ○ |
| [yazi](https://github.com/sxyazi/yazi) | yazi.nvim | ○ |
| [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) + C コンパイラ | nvim-treesitter のパーサービルド | ○ (コンパイラは MSVC) |
| Nerd Font | アイコン表示 (例: [JetBrainsMono Nerd Font](https://www.nerdfonts.com/)) | ○ |
| [ImageMagick](https://imagemagick.org/) (`magick`) | image.nvim の画像変換 | 不要 |
| [mermaid-cli](https://github.com/mermaid-js/mermaid-cli) (`mmdc`) | diagram.nvim の Mermaid 描画 | 不要 |
| Kitty graphics protocol 対応ターミナル (Ghostty / Kitty / WezTerm) | image.nvim の画像表示 | 不要 |

Windows Terminal は Kitty graphics protocol に非対応のため、Windows では image.nvim / diagram.nvim を読み込めません。

## Ubuntu / Debian

```bash
sudo apt-get install ripgrep imagemagick build-essential

# yazi (cargo を使う場合)
cargo install yazi-fm yazi-cli

# nvm で Node.js/npm をインストール後
npm install -g tree-sitter-cli @mermaid-js/mermaid-cli
```

## macOS

```bash
brew install ripgrep yazi tree-sitter-cli imagemagick
npm install -g @mermaid-js/mermaid-cli
```

C コンパイラは Xcode Command Line Tools (`xcode-select --install`)を使います。

### Ubuntu / macos 共通: 設定の配置

```bash
# 既存の設定をバックアップ
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null

# リポジトリをクローン
git clone https://github.com/syn-z27/nvim-dotfiles.git ~/.config/nvim
```

---

## Windows (Git Bash)

### ツールのインストール

```bash
winget install --id BurntSushi.ripgrep.MSVC -e
winget install --id sxyazi.yazi -e
winget install --id tree-sitter.tree-sitter-cli -e
```

- tree-sitter CLI は **winget 版を使う**。npm 版 (`npm install -g tree-sitter-cli`)は拡張子なしのシェルスクリプト経由で起動されるため、Neovim から実行できず `ENOENT` になる。
- C コンパイラには Visual Studio Build Tools の MSVC (「 C++ によるデスクトップ開発」ワークロード)を使う。tree-sitter CLI が自動で検出する。
- インストール後は PATH を反映させるため、ターミナルのタブを開き直す。

### 設定の配置

Windows 版 Neovim は `~/.config/nvim` ではなく `%LOCALAPPDATA%\nvim` を読むため、クローンしたリポジトリへジャンクションを張ります（管理者権限は不要）。

```bash
git clone https://github.com/syn-z27/nvim-dotfiles.git ~/projects/nvim-dotfiles
cmd //c mklink //J "%LOCALAPPDATA%\\nvim" "%USERPROFILE%\\projects\\nvim-dotfiles"
```

### Windows で無効にしている機能

| 対象 | 内容 | 理由 |
|---|---|---|
| image.nvim / diagram.nvim | 読み込まない | Windows Terminal が Kitty graphics protocol 非対応 |
| lazy.nvim の `checker` | 起動時の更新チェックをしない | プロセス起動が重く、全プラグインの git 実行で数秒 UI が固まる |
| dashboard の Recent Projects | 表示しない | 一覧が空のとき `empty project` 行で `<CR>` を押すとプラグイン側でエラーになる |

また、Git Bash から起動すると Neovim が `$SHELL` (bash) を引き継ぐため、 `:!` が動くよう bash 用の `shellcmdflag` 等を設定しています (`lua/config/options.lua`)

---

## 初回起動

Neovim を起動すると lazy.nvim が自動でインストールされ、全プラグインが導入されます。

```bash
nvim
```

Treesitter パーサー (java / kotlin / lua / vim / vimdoc)はファイルを開いたときに自動でビルドされます。手動で更新する場合は次を実行します。

```
:TSUpdate
```

---

## アップデート

```vim
:Lazy update
```

ダッシュボードの `u` でも実行できます。Windows では起動時の自動チェックを無効にしているため、手動で実行してください。

---

## ディレクトリ参照

プラグインデータは Neovim の標準データパスに保存されます。

| 用途 | Ubuntu / macOS | Windows |
|---|---|---|
| 設定ファイル | `~/.config/nvim/` | `%LOCALAPPDATA%\nvim\` |
| プラグイン本体 | `~/.local/share/nvim/lazy/` | `%LOCALAPPDATA%\nvim-data\lazy\` |
| Treesitter パーサー | `~/.local/share/nvim/lazy/nvim-treesitter/parser/` | `%LOCALAPPDATA%\nvim-data\site\parser\` |


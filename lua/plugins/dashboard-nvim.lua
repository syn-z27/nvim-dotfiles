-- dashboard-nvim: Neovim起動時に表示されるスタート画面プラグイン。
-- カスタマイズ:
--   - theme=hyper: hyperテーマを使用。
--   - week_header: 曜日を含むヘッダーを表示。
--   - ショートカット: `u` でプラグイン更新、`f` でファイル検索 (Telescope)、`q` で終了。
--   - `:DA` コマンドでダッシュボードを再表示。
return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  priority = 1000,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    theme = "hyper",
    config = {
      week_header = {
        enable = true
      },
      -- Windows ではプロジェクト一覧が空のとき "empty project" 行で <CR> を押すと
      -- hyper.lua のパス解析が nil になりエラーになるため、プロジェクト欄を出さない
      project = {
        enable = vim.fn.has("win32") == 0
      },
      shortcut = { {
        desc = " Update",
        group = "@property",
        action = "Lazy update",
        key = "u"
      }, {
        icon = " ",
        icon_hl = "@variable",
        desc = "Files",
        group = "Label",
        action = "Telescope find_files",
        key = "f"
      }, {
        desc = " Quit",
        group = "DiagnosticError",
        action = "qa",
        key = "q"
      } }
    }
  },
  config = function(_, opts)
    require("dashboard").setup(opts)
    vim.api.nvim_create_user_command("DA", "Dashboard", {})
  end
}

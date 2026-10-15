vim.opt.number = true

vim.api.nvim_set_hl(0, "LineNr", { fg = "#aaaaaa" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bold = true })

vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.showtabline = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.shada = "!,'10,<50,s10,h"
vim.opt.autoread = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.virtualedit = "onemore"
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.whichwrap:append("<,>,[,]")
vim.opt.hlsearch = true
-- ダッシュボードが描画されるまでの一瞬、標準の起動画面 (intro) が見えるのを防ぐ
vim.opt.shortmess:append("I")

-- Git Bash から起動すると $SHELL (bash) を引き継ぐが、フラグは cmd.exe 用 (/s /c)のままで
-- :! やシェル経由のコマンドが失敗するため、bash 用のフラグに揃える
if vim.fn.has("win32") == 1 and vim.o.shell:find("bash") then
  vim.opt.shellcmdflag = "-c"
  vim.opt.shellredir = ">%s 2>&1"
  vim.opt.shellpipe = "2>&1 | tee"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end
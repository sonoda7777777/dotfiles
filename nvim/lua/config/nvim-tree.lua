-- netrw を無効化（nvim-tree 推奨設定）
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

-- <C-n> でファイルツリーをトグル
vim.keymap.set("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>", { silent = true })

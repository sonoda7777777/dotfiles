require("barbar").setup({
  animation = true,
  icons = {
    button = "",
    filetype = { enabled = true },
  },
})

local opts = { noremap = true, silent = true }

-- バッファ移動
vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)

-- バッファ並び替え
vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

-- 番号で直接ジャンプ
for i = 1, 9 do
  vim.keymap.set("n", "<A-" .. i .. ">", "<Cmd>BufferGoto " .. i .. "<CR>", opts)
end
vim.keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

-- バッファを閉じる
vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)

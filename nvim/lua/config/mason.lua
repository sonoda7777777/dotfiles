require("mason").setup()
require("mason-lspconfig").setup()

-- Mason経由で有効化されるLSPサーバー全てにnvim-cmp用capabilitiesを適用
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

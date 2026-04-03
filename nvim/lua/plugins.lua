return {
  -- ペア自動補完
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- 自動補完
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Lua開発補助（vim.*の補完・警告解消）
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },
}

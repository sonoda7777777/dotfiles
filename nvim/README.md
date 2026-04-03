# Neovim Configuration

## ディレクトリ構成

```
nvim/
├── init.lua          -- エントリポイント
└── lua/
    ├── options.lua   -- 基本設定（表示・インデント）
    ├── plugins.lua   -- プラグイン一覧（lazy.nvim）
    └── config/
        ├── cmp.lua   -- 自動補完設定
        └── mason.lua -- LSPサーバー管理
```

## 各ファイルの説明

### `init.lua`
エントリポイント。lazy.nvim の自動インストールと各モジュールの読み込みを行う。

### `lua/options.lua`
- 背景の透過設定
- 行番号の表示
- インデント設定（タブ幅2、スペース変換）

### `lua/plugins.lua`
lazy.nvim で管理するプラグイン一覧。

| プラグイン | 用途 |
|-----------|------|
| windwp/nvim-autopairs | 括弧の自動補完 |
| hrsh7th/nvim-cmp | 自動補完エンジン |
| L3MON4D3/LuaSnip | スニペット |
| neovim/nvim-lspconfig | LSP設定 |
| williamboman/mason.nvim | LSPサーバー管理 |
| folke/lazydev.nvim | Lua開発補助 |

### `lua/config/cmp.lua`
nvim-cmp の補完設定。キーマップは以下の通り。

| キー | 動作 |
|------|------|
| `<Tab>` | 次の候補 |
| `<S-Tab>` | 前の候補 |
| `<CR>` | 確定 |
| `<C-Space>` | 補完を開く |
| `<C-e>` | 補完を閉じる |

### `lua/config/mason.lua`
Mason によるLSPサーバーの自動インストール設定。

## 依存関係

- Neovim 0.9+
- Git

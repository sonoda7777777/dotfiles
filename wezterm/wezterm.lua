local wezterm = require 'wezterm'

return {
  -- 起動時のデフォルトシェルをGit Bashに設定
  default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe" },

  -- ウィンドウ全体の不透明度（0.0=完全透明 〜 1.0=不透明）
  window_background_opacity = 0.85,

  colors = {
    tab_bar = {
      -- タブバー背景色（rgba の第4引数で透明度を指定）
      background = 'rgba(0, 0, 0, 0.5)',

      -- アクティブなタブ
      active_tab = {
        bg_color = 'rgba(40, 40, 40, 0.7)',
        fg_color = '#ffffff',
      },

      -- 非アクティブなタブ
      inactive_tab = {
        bg_color = 'rgba(20, 20, 20, 0.5)',
        fg_color = '#aaaaaa',
      },

      -- 非アクティブなタブにカーソルを合わせたとき
      inactive_tab_hover = {
        bg_color = 'rgba(35, 35, 35, 0.6)',
        fg_color = '#cccccc',
      },

      -- 新規タブボタン
      new_tab = {
        bg_color = 'rgba(20, 20, 20, 0.5)',
        fg_color = '#aaaaaa',
      },

      -- 新規タブボタンにカーソルを合わせたとき
      new_tab_hover = {
        bg_color = 'rgba(35, 35, 35, 0.6)',
        fg_color = '#cccccc',
      },
    },
  },
}

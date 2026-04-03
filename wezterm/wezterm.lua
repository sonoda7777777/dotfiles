local wezterm = require 'wezterm'

-- プロセス名 → アイコン対応テーブル（エディタ検出用）
local process_icons = {
  vim   = wezterm.nerdfonts.custom_vim,
  nvim  = wezterm.nerdfonts.custom_vim,
  nano  = wezterm.nerdfonts.md_file_edit_outline,
  emacs = wezterm.nerdfonts.custom_emacs,
  hx    = wezterm.nerdfonts.md_file_edit_outline, -- Helix
  code  = wezterm.nerdfonts.md_microsoft_visual_studio_code,
}

-- 拡張子 → アイコン対応テーブル
local ext_icons = {
  lua  = wezterm.nerdfonts.seti_lua,
  py   = wezterm.nerdfonts.seti_python,
  js   = wezterm.nerdfonts.seti_javascript,
  ts   = wezterm.nerdfonts.seti_typescript,
  rs   = wezterm.nerdfonts.seti_rust,
  go   = wezterm.nerdfonts.seti_go,
  rb   = wezterm.nerdfonts.seti_ruby,
  sh   = wezterm.nerdfonts.seti_shell,
  md   = wezterm.nerdfonts.seti_markdown,
  json = wezterm.nerdfonts.seti_json,
  toml = wezterm.nerdfonts.seti_config,
  yaml = wezterm.nerdfonts.seti_yml,
  html = wezterm.nerdfonts.seti_html,
  css  = wezterm.nerdfonts.seti_css,
  c    = wezterm.nerdfonts.custom_c,
  h    = wezterm.nerdfonts.custom_c,
  cpp  = wezterm.nerdfonts.custom_cpp,
  hpp  = wezterm.nerdfonts.custom_cpp,
}

local function get_ext(title)
  -- "(modified)" などの後置詞にも対応
  return title:match("%.(%w+)%s*$")
      or title:match("%.(%w+)%s*%(")
      or title:match("%.(%w+)")
end

-- タイトル文字列からエディタを検出（foreground_process_name が更新されない場合のフォールバック）
local function detect_editor_from_title(title)
  if title:find("GNU nano", 1, true) then return "nano" end
  if title:find("NVIM", 1, true)     then return "nvim" end
  if title:find("- VIM", 1, true)    then return "vim"  end
  return nil
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  local process = tab.active_pane.foreground_process_name or ""

  -- プロセス名のベース名を取得（パスと .exe を除去）
  local process_name = process:match("([^/\\]+)$") or process
  process_name = process_name:gsub("%.exe$", ""):lower()

  -- Windows + Git Bash では foreground_process_name が bash のままになることがあるため
  -- タイトルからエディタを検出してフォールバック
  if process_name == "bash" or process_name == "" then
    process_name = detect_editor_from_title(title) or process_name
  end

  -- タイトルから拡張子を抽出（nano は特殊フォーマット対応）
  local ext
  if process_name == "nano" then
    ext = title:match("%s+%S-%.(%w+)%s*$")
       or title:match("%s+%S-%.(%w+)%s*%(")
       or get_ext(title)
  else
    ext = get_ext(title)
  end

  wezterm.log_info("title=" .. title .. " | process=" .. process .. " | process_name=" .. process_name .. " | ext=" .. (ext or "nil"))

  local icon
  if ext and ext_icons[ext:lower()] then
    -- ファイル拡張子で判定できた場合はそちらを優先
    icon = ext_icons[ext:lower()]
  elseif process_icons[process_name] then
    -- エディタ等のプロセス名で判定
    icon = process_icons[process_name]
  end

  icon = icon or wezterm.nerdfonts.dev_terminal
  return {
    { Text = icon .. " " .. title },
  }
end)

local bash = "C:\\Program Files\\Git\\bin\\bash.exe"

return {
  -- 起動時にピカチュウを表示してからGit Bashを起動
  default_prog = { bash, "-c", 'bash "$HOME/dotfiles/wezterm/pikachu.sh"; exec bash' },

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

local wezterm = require 'wezterm'

-- プロセス名 → アイコン対応テーブル
local process_icons = {
  vim   = wezterm.nerdfonts.custom_vim,
  nvim  = wezterm.nerdfonts.custom_vim,
  nano  = wezterm.nerdfonts.md_file_edit_outline,
  emacs = wezterm.nerdfonts.custom_emacs,
  hx    = wezterm.nerdfonts.md_file_edit_outline,
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

-- タイトル文字列からファイルの拡張子を抽出する
local function get_ext(title)
  return title:match("%.(%w+)%s*$")
      or title:match("%.(%w+)%s*%(")
      or title:match("%.(%w+)")
end

-- タイトル文字列からエディタ名を検出する（foreground_process_nameが取得できない場合のフォールバック）
local function detect_editor_from_title(title)
  if title:find("GNU nano", 1, true) then return "nano" end
  if title:find("NVIM", 1, true)     then return "nvim" end
  if title:find("- VIM", 1, true)    then return "vim"  end
  return nil
end

-- タブのフォアグラウンドプロセス名を取得する（パスと.exeを除去し小文字化）
local function get_process_name(tab)
  local process = tab.active_pane.foreground_process_name or ""
  local name = process:match("([^/\\]+)$") or process
  name = name:gsub("%.exe$", ""):lower()

  if name == "bash" or name == "" then
    name = detect_editor_from_title(tab.active_pane.title) or name
  end

  return name
end

-- タイトルとプロセス名からタブに表示するアイコンを決定する
local function get_icon(title, process_name)
  local ext
  if process_name == "nano" then
    ext = title:match("%s+%S-%.(%w+)%s*$")
       or title:match("%s+%S-%.(%w+)%s*%(")
       or get_ext(title)
  else
    ext = get_ext(title)
  end

  if ext and ext_icons[ext:lower()] then
    return ext_icons[ext:lower()]
  elseif process_icons[process_name] then
    return process_icons[process_name]
  end

  return wezterm.nerdfonts.dev_terminal
end

wezterm.on("format-tab-title", function(tab)
  local title = tab.active_pane.title
  local process_name = get_process_name(tab)
  local icon = get_icon(title, process_name)

  if tab.is_active then
    return { { Text = icon .. " " .. title } }
  end

  return { { Text = icon .. " " .. wezterm.truncate_right(title, 2) } }
end)

local bash = "C:\\Program Files\\Git\\bin\\bash.exe"

return {
  default_prog = { bash, "--login" },
  window_decorations = "RESIZE",

  background = {
    {
      source = { Color = "#000000" },
      width = "100%",
      height = "100%",
      opacity = 0.85,
    },
    {
      source = { File = "C:\\Users\\Owner\\dotfiles\\wezterm\\backgrounds\\sanraku.png" },
      width = "30%",
      height = "100%",
      opacity = 0.85,
      horizontal_align = "Right",
    },
  },

  window_frame = {
    inactive_titlebar_bg = "none",
    active_titlebar_bg = "none",
  },

  colors = {
    tab_bar = {
      background = 'rgba(0, 0, 0, 0.5)',
      active_tab = {
        bg_color = 'rgba(0, 71, 171, 0.8)',
        fg_color = '#ffffff',
      },
      inactive_tab = {
        bg_color = 'rgba(20, 20, 20, 0.5)',
        fg_color = '#aaaaaa',
      },
      inactive_tab_hover = {
        bg_color = 'rgba(35, 35, 35, 0.6)',
        fg_color = '#cccccc',
      },
      new_tab = {
        bg_color = 'rgba(20, 20, 20, 0.5)',
        fg_color = '#aaaaaa',
      },
      new_tab_hover = {
        bg_color = 'rgba(35, 35, 35, 0.6)',
        fg_color = '#cccccc',
      },
    },
  },
}

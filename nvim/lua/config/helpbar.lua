-- nano風の常時ヘルプバー（画面下に固定表示）
local M = {}

-- 表示するキー一覧（行数ぶんの高さで固定される）
local hints = {
  " p ペースト   y ヤンク(コピー)   dd 行削除   u 元に戻す   <C-r> やり直し",
  " i 挿入   :w 保存   :q 終了   / 検索   <C-n> ツリー   gd 定義へ",
}

local buf, win

local function create()
  -- すでに開いていれば何もしない
  if win and vim.api.nvim_win_is_valid(win) then
    return
  end

  -- ヘルプ用スクラッチバッファ
  buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "hide"
  vim.bo[buf].swapfile = false
  vim.bo[buf].buflisted = false
  vim.bo[buf].filetype = "helpbar"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, hints)
  vim.bo[buf].modifiable = false

  -- 一番下に分割して開く
  vim.cmd("botright " .. #hints .. "split")
  win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_win_set_height(win, #hints)

  -- ウィンドウの見た目を固定
  local wo = vim.wo[win]
  wo.number = false
  wo.relativenumber = false
  wo.cursorline = false
  wo.winfixheight = true
  wo.signcolumn = "no"
  wo.list = false
  wo.wrap = false

  -- 本文側へカーソルを戻す
  vim.cmd("wincmd p")
end

function M.setup()
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = create,
  })

  -- ヘルプバーにフォーカスが入ったら本文側へ戻す（編集対象にしない）
  vim.api.nvim_create_autocmd("WinEnter", {
    callback = function()
      if win and vim.api.nvim_get_current_win() == win then
        if #vim.api.nvim_tabpage_list_wins(0) > 1 then
          vim.cmd("wincmd p")
        end
      end
    end,
  })

  -- 最後の編集ウィンドウを閉じたらヘルプバーも閉じて終了できるようにする
  vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
      if not (win and vim.api.nvim_win_is_valid(win)) then
        return
      end
      -- ヘルプバー以外のフローティングでない通常ウィンドウを数える
      local editing = 0
      for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local cfg = vim.api.nvim_win_get_config(w)
        if cfg.relative == "" and w ~= win then
          editing = editing + 1
        end
      end
      -- 残りがヘルプバーだけになるなら一緒に閉じる
      if editing <= 1 then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })
end

M.setup()

return M

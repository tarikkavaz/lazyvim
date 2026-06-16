local M = {
  default_enabled = false,
  env_var = "NVIM_GUI_KEYS",
}

local disabled_values = {
  ["0"] = true,
  ["false"] = true,
  ["no"] = true,
  ["off"] = true,
}

local enabled_values = {
  ["1"] = true,
  ["true"] = true,
  ["yes"] = true,
  ["on"] = true,
}

local env_value = vim.env[M.env_var]
local normalized_env = env_value and env_value:lower() or nil

if normalized_env and disabled_values[normalized_env] then
  M.enabled = false
  M.enabled_source = M.env_var .. "=" .. env_value
elseif normalized_env and enabled_values[normalized_env] then
  M.enabled = true
  M.enabled_source = M.env_var .. "=" .. env_value
else
  M.enabled = M.default_enabled
  M.enabled_source = "default_enabled"
end

function M.is_enabled()
  return M.enabled
end

function M.status()
  return ("GUI keybindings are %s (%s). Changes require a Neovim restart."):format(
    M.enabled and "enabled" or "disabled",
    M.enabled_source
  )
end

function M.setup_options()
  vim.api.nvim_create_user_command("GuiKeybindingsStatus", function()
    vim.notify(M.status(), vim.log.levels.INFO, { title = "GUI Keybindings" })
  end, {
    desc = "Show whether the GUI-friendly keybinding profile is enabled",
    force = true,
  })

  if not M.enabled then
    return
  end

  vim.opt.scrolloff = 8
  vim.opt.selection = "exclusive"
  vim.opt.selectmode = { "mouse", "key" }
  vim.opt.keymodel = { "startsel", "stopsel" }
end

local function diagnostic_jump(count)
  return function()
    vim.diagnostic.jump({ count = count, float = true })
  end
end

local function map(mode, lhs, rhs, desc, opts)
  vim.keymap.set(
    mode,
    lhs,
    rhs,
    vim.tbl_extend("force", {
      desc = desc,
      silent = true,
    }, opts or {})
  )
end

local function save()
  vim.cmd.write()
end

local function quick_open()
  Snacks.picker.files({ cwd = LazyVim.root() })
end

local function project_search()
  Snacks.picker.grep({ cwd = LazyVim.root() })
end

local function toggle_terminal()
  Snacks.terminal.focus(nil, { cwd = LazyVim.root() })
end

function M.setup_keymaps()
  if not M.enabled then
    return
  end

  -- Files and commands
  map({ "n", "i", "x", "s" }, "<C-s>", save, "Save File")
  map({ "n", "i", "x", "s" }, "<D-s>", save, "Save File")
  map("n", "<C-p>", quick_open, "Quick Open File")
  map("n", "<D-p>", quick_open, "Quick Open File")
  map("n", "<C-S-p>", function()
    Snacks.picker.commands()
  end, "Show Commands")
  map("n", "<F1>", function()
    Snacks.picker.commands()
  end, "Show Commands")
  map("n", "<C-n>", "<cmd>enew<cr>", "New File")
  map("n", "<M-w>", function()
    Snacks.bufdelete()
  end, "Close Editor")
  map("n", "<C-F4>", function()
    Snacks.bufdelete()
  end, "Close Editor")

  -- Editor tabs
  map({ "n", "i", "x", "s" }, "<C-Tab>", "<cmd>bnext<cr>", "Next Editor Tab")
  map({ "n", "i", "x", "s" }, "<C-S-Tab>", "<cmd>bprevious<cr>", "Previous Editor Tab")

  -- Search
  map("n", "<C-f>", "/", "Find in File")
  map({ "i", "x", "s" }, "<C-f>", "<Esc>/", "Find in File")
  map("n", "<C-S-f>", project_search, "Search Project")
  map("n", "<C-S-h>", "<cmd>GrugFar<cr>", "Replace in Project")
  map("n", "<F3>", "n", "Next Search Result", { remap = true })
  map("n", "<S-F3>", "N", "Previous Search Result", { remap = true })

  -- Word movement and selection
  map("n", "<M-Left>", "b", "Move One Word Left")
  map("n", "<M-Right>", "w", "Move One Word Right")
  map("i", "<M-Left>", "<C-o>b", "Move One Word Left")
  map("i", "<M-Right>", "<C-o>w", "Move One Word Right")
  map("n", "<M-S-Left>", "vb<C-g>", "Select One Word Left")
  map("n", "<M-S-Right>", "vw<C-g>", "Select One Word Right")
  map("i", "<M-S-Left>", "<Esc>vb<C-g>", "Select One Word Left")
  map("i", "<M-S-Right>", "<Esc>vw<C-g>", "Select One Word Right")
  map("s", "<M-S-Left>", "<C-g>b<C-g>", "Select One Word Left")
  map("s", "<M-S-Right>", "<C-g>w<C-g>", "Select One Word Right")

  -- Clipboard and undo
  map("n", "<C-a>", "gg0vG$<C-g>", "Select All")
  map("i", "<C-a>", "<Esc>gg0vG$<C-g>", "Select All")
  map("s", "<C-a>", "<Esc>gg0vG$<C-g>", "Select All")
  map({ "x", "s" }, "<C-c>", '"+y', "Copy")
  map({ "x", "s" }, "<C-x>", '"+d', "Cut")
  map("i", "<C-v>", "<C-r>+", "Paste")
  map("x", "<C-v>", '"_d"+P', "Paste")
  map("s", "<C-v>", '<C-g>"_d"+P', "Paste")
  map("n", "<C-z>", "u", "Undo")
  map("i", "<C-z>", "<C-o>u", "Undo")
  map("s", "<C-z>", "<Esc>u", "Undo")
  map("n", "<C-S-z>", "<C-r>", "Redo")
  map("i", "<C-S-z>", "<C-o><C-r>", "Redo")
  map("s", "<C-S-z>", "<Esc><C-r>", "Redo")

  -- Code navigation and actions
  map("n", "<F2>", vim.lsp.buf.rename, "Rename Symbol")
  map("n", "<F12>", vim.lsp.buf.definition, "Go to Definition")
  map("n", "<S-F12>", vim.lsp.buf.references, "Find References")
  map({ "n", "x" }, "<C-.>", vim.lsp.buf.code_action, "Code Action")
  map({ "n", "x" }, "<D-.>", vim.lsp.buf.code_action, "Code Action")
  map("n", "<M-/>", "gcc", "Toggle Line Comment", { remap = true })
  map("x", "<M-/>", "gc", "Toggle Selection Comment", { remap = true })
  map("n", "<D-/>", "gcc", "Toggle Line Comment", { remap = true })
  map("x", "<D-/>", "gc", "Toggle Selection Comment", { remap = true })
  map({ "n", "x" }, "<M-S-f>", function()
    LazyVim.format({ force = true })
  end, "Format Document")
  map("n", "<F8>", diagnostic_jump(1), "Next Problem")
  map("n", "<S-F8>", diagnostic_jump(-1), "Previous Problem")
  map("n", "<C-S-m>", function()
    Snacks.picker.diagnostics()
  end, "Show Problems")

  -- Editor groups and terminal
  map("n", "<C-A-Left>", "<C-w>h", "Focus Left Editor Group", { remap = true })
  map("n", "<C-A-Down>", "<C-w>j", "Focus Lower Editor Group", { remap = true })
  map("n", "<C-A-Up>", "<C-w>k", "Focus Upper Editor Group", { remap = true })
  map("n", "<C-A-Right>", "<C-w>l", "Focus Right Editor Group", { remap = true })
  map("n", "<C-A-S-Left>", "<cmd>vertical resize -2<cr>", "Shrink Editor Group Width")
  map("n", "<C-A-S-Right>", "<cmd>vertical resize +2<cr>", "Grow Editor Group Width")
  map("n", "<C-A-S-Up>", "<cmd>resize +2<cr>", "Grow Editor Group Height")
  map("n", "<C-A-S-Down>", "<cmd>resize -2<cr>", "Shrink Editor Group Height")
  map("n", "<C-\\>", "<C-w>v", "Split Editor Right", { remap = true })
  map({ "n", "t" }, "<C-`>", toggle_terminal, "Toggle Terminal")

  -- Friendly aliases for native LazyVim fallbacks
  map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", "Previous Editor Tab")
  map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", "Next Editor Tab")
  map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", "Previous Editor Tab")
  map("n", "]b", "<cmd>BufferLineCycleNext<cr>", "Next Editor Tab")
  map("n", "<leader>,", function()
    Snacks.picker.buffers()
  end, "Open Editor Tabs")
  map("n", "<leader>bd", function()
    Snacks.bufdelete()
  end, "Close Editor")
  map("n", "<leader>bo", function()
    Snacks.bufdelete.other()
  end, "Close Other Editors")
  map("n", "<leader>bi", function()
    Snacks.bufdelete.invisible()
  end, "Close Hidden Editors")
  map("n", "<leader>bD", "<cmd>bd<cr>", "Close Editor and Group")
  map("n", "<leader>wd", "<C-w>c", "Close Editor Group", { remap = true })
end

return M

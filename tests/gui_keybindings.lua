local expected_enabled = vim.env.EXPECT_GUI_KEYS == "1"

local function fail(message)
  error(message, 0)
end

local function assert_equal(actual, expected, label)
  if not vim.deep_equal(actual, expected) then
    fail(("%s\nexpected: %s\nactual:   %s"):format(label, vim.inspect(expected), vim.inspect(actual)))
  end
end

local function assert_mapping(lhs, mode, expected_desc)
  local mapping = vim.fn.maparg(lhs, mode, false, true)
  if vim.tbl_isempty(mapping) then
    fail(("missing %s mapping for %s"):format(mode, lhs))
  end
  assert_equal(mapping.desc, expected_desc, ("wrong description for %s in %s mode"):format(lhs, mode))
end

local function assert_no_mapping(lhs, mode)
  local mapping = vim.fn.maparg(lhs, mode, false, true)
  if not vim.tbl_isempty(mapping) then
    fail(("unexpected %s mapping for %s: %s"):format(mode, lhs, vim.inspect(mapping)))
  end
end

local profile = require("config.gui_keybindings")
assert_equal(profile.is_enabled(), expected_enabled, "profile enabled state")

vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })

if expected_enabled then
  assert_equal(vim.o.scrolloff, 8, "GUI profile scrolloff")
  assert_equal(vim.o.selection, "exclusive", "GUI profile selection")
  assert_equal(vim.o.selectmode, "mouse,key", "GUI profile selectmode")
  assert_equal(vim.o.keymodel, "startsel,stopsel", "GUI profile keymodel")

  assert_mapping("<C-Tab>", "n", "Next Editor Tab")
  assert_mapping("<C-S-Tab>", "n", "Previous Editor Tab")
  assert_mapping("<M-w>", "n", "Close Editor")
  assert_mapping("<C-p>", "n", "Quick Open File")
  assert_mapping("<C-S-p>", "n", "Show Commands")
  assert_mapping("<F2>", "n", "Rename Symbol")
  assert_mapping("<F12>", "n", "Go to Definition")
  assert_mapping("<C-A-Left>", "n", "Focus Left Editor Group")
  assert_mapping("<M-Left>", "i", "Move One Word Left")
  assert_mapping("<C-v>", "i", "Paste")
  assert_mapping("<leader>bd", "n", "Close Editor")

  assert_no_mapping("<C-n>", "i")
  assert_no_mapping("<C-p>", "i")

  vim.opt.clipboard = ""
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { "abc" })
  vim.api.nvim_win_set_cursor(0, { 1, 1 })
  vim.api.nvim_feedkeys(vim.keycode("<S-Right>X<Esc>"), "xt", false)
  assert_equal(vim.api.nvim_get_current_line(), "aXc", "Shift+Arrow selection should use an exclusive end position")

  vim.api.nvim_buf_set_lines(0, 0, -1, false, { "alpha beta" })
  vim.api.nvim_win_set_cursor(0, { 1, 6 })
  vim.api.nvim_feedkeys(vim.keycode("<M-S-Right>"), "xt", false)
  assert_equal(vim.api.nvim_get_mode().mode, "s", "Shift+Option+Arrow should enter Select mode")
  vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "xt", false)
else
  assert_equal(vim.o.scrolloff, 4, "stock LazyVim scrolloff")
  assert_equal(vim.o.selection, "inclusive", "stock LazyVim selection")
  assert_equal(vim.o.selectmode, "", "stock LazyVim selectmode")
  assert_equal(vim.o.keymodel, "", "stock LazyVim keymodel")

  assert_no_mapping("<C-Tab>", "n")
  assert_no_mapping("<C-S-Tab>", "n")
  assert_no_mapping("<M-w>", "n")
  assert_no_mapping("<C-p>", "n")
  assert_no_mapping("<F2>", "n")
  assert_no_mapping("<C-A-Left>", "n")
  assert_no_mapping("<M-Left>", "i")
  assert_mapping("<leader>bd", "n", "Delete Buffer")
end

local lazy_plugin = require("lazy.core.plugin")
local lazy_config = require("lazy.core.config")

local bufferline_opts = lazy_plugin.values(lazy_config.plugins["bufferline.nvim"], "opts", false)
assert_equal(
  bufferline_opts.options.always_show_bufferline,
  expected_enabled,
  "Bufferline visibility should follow the GUI profile"
)

local snacks_opts = lazy_plugin.values(lazy_config.plugins["snacks.nvim"], "opts", false)
local explorer_win = snacks_opts.picker.sources.explorer.win
local explorer_keys = explorer_win and explorer_win.list.keys or nil
if expected_enabled then
  assert_equal(explorer_keys["<F2>"], "explorer_rename", "Explorer rename mapping")
  assert_equal(explorer_keys["<Delete>"], "explorer_del", "Explorer delete mapping")
  assert_equal(explorer_keys["<C-c>"], "explorer_copy_paths", "Explorer copy mapping")
  assert_equal(explorer_keys["<C-v>"], "explorer_paste", "Explorer paste mapping")
  assert_equal(
    type(snacks_opts.picker.sources.explorer.actions.explorer_copy_paths),
    "function",
    "Explorer copy action"
  )
else
  assert_equal(explorer_keys, nil, "Explorer GUI mappings should be absent")
end

local which_key_opts = lazy_plugin.values(lazy_config.plugins["which-key.nvim"], "opts", false)
local groups = {}
for _, spec in ipairs(which_key_opts.spec) do
  if spec.group then
    groups[spec[1]] = spec.group
  end
end
assert_equal(groups["<leader>b"], expected_enabled and "editor tabs" or nil, "which-key editor-tab group")
assert_equal(groups["<leader>w"], expected_enabled and "editor groups" or nil, "which-key editor-group group")

print(("gui-keybindings:%s"):format(expected_enabled and "enabled" or "disabled"))

return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      local function copy_explorer_paths(picker)
        if vim.fn.mode():find("^[vV]") then
          picker.list:select()
        end

        local paths = {}
        for _, item in ipairs(picker:selected({ fallback = true })) do
          paths[#paths + 1] = Snacks.picker.util.path(item)
        end

        picker.list:set_selected()
        vim.fn.setreg(vim.v.register or "+", table.concat(paths, "\n"), "l")
        Snacks.notify.info(("Copied %d file path%s"):format(#paths, #paths == 1 and "" or "s"))
      end

      opts.picker = opts.picker or {}
      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.explorer = vim.tbl_deep_extend("force", opts.picker.sources.explorer or {}, {
        hidden = true,
        ignored = true,
        layout = {
          layout = {
            position = "right",
          },
        },
      })

      if require("config.gui_keybindings").is_enabled() then
        opts.picker.sources.explorer = vim.tbl_deep_extend("force", opts.picker.sources.explorer, {
          actions = {
            explorer_copy_paths = copy_explorer_paths,
          },
          win = {
            list = {
              keys = {
                ["<Left>"] = "explorer_close",
                ["<Right>"] = "confirm",
                ["<F2>"] = "explorer_rename",
                ["<Delete>"] = "explorer_del",
                ["<C-c>"] = "explorer_copy_paths",
                ["<C-v>"] = "explorer_paste",
              },
            },
          },
        })
      end
    end,
  },
}

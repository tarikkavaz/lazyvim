return {
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      local profile = require("config.gui_keybindings")
      if not profile.is_enabled() then
        return opts
      end

      opts.options = opts.options or {}
      opts.options.always_show_bufferline = true
      opts.options.close_command = function(buffer)
        Snacks.bufdelete(buffer)
      end
      opts.options.right_mouse_command = function(buffer)
        Snacks.bufdelete(buffer)
      end
      opts.options.middle_mouse_command = function(buffer)
        Snacks.bufdelete(buffer)
      end
    end,
  },
}

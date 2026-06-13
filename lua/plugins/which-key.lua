return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      if not require("config.gui_keybindings").is_enabled() then
        return opts
      end

      opts.spec = opts.spec or {}
      vim.list_extend(opts.spec, {
        { "<leader>b", group = "editor tabs" },
        { "<leader>w", group = "editor groups" },
      })
    end,
  },
}

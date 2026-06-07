return {
  {
    "mattn/emmet-vim",
    ft = {
      "html",
      "css",
      "scss",
      "javascriptreact",
      "typescriptreact",
      "vue",
      "svelte",
    },
    init = function()
      vim.g.user_emmet_install_global = 0
    end,
    config = function()
      vim.cmd([[
        autocmd FileType html,css,scss,javascriptreact,typescriptreact,vue,svelte EmmetInstall
      ]])

      vim.keymap.set("i", "<C-e>", function()
        vim.fn["emmet#expandAbbr"](3, "")
      end, {
        buffer = true,
        silent = true,
        desc = "Emmet expand abbreviation",
      })
    end,
  },
}

return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "yetone/avante.nvim",
    },
    build = "npm install -g mcp-hub@latest",
    cmd = { "MCPHub" },
    keys = {
      { "<leader>aH", "<cmd>MCPHub<CR>", desc = "MCP Hub" },
    },
    opts = {
      config = vim.fn.stdpath("config") .. "/mcphub/servers.json",
      global_env = {
        "CONTEXT7_API_KEY",
      },
      extensions = {
        avante = {
          make_slash_commands = true,
        },
      },
    },
  },
}

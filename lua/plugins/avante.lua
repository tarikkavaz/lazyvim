return {
  {
    "yetone/avante.nvim",
    opts = {
      provider = "openai",
      mode = "legacy",
      providers = {
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-5.5",
          timeout = 60000,
          disable_tools = true,
        },
      },
    },
  },
}
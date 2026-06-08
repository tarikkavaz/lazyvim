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
          -- gpt-5.x + MCP tools requires /v1/responses, not /v1/chat/completions
          use_response_api = true,
          support_previous_response_id = true,
        },
      },
      system_prompt = function()
        local ok, hub = pcall(require, "mcphub")
        if not ok then
          return ""
        end
        local instance = hub.get_hub_instance()
        return instance and instance:get_active_servers_prompt() or ""
      end,
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.marksman = opts.servers.marksman or {}
      opts.servers.marksman.handlers = opts.servers.marksman.handlers or {}

      -- Disable Markdown LSP diagnostics, including link-related warnings.
      opts.servers.marksman.handlers["textDocument/publishDiagnostics"] = function() end

      return opts
    end,
  },
}

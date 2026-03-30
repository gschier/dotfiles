require("typescript-tools").setup({
  on_attach = function(client, bufnr)
    -- Disable its own formatter so Prettier or other tools can take over
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
  settings = {
    -- (whatever other options you have)
  },
})

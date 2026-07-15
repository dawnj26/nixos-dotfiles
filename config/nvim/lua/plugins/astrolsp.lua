---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    formatting = {
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
      },
      timeout_ms = 1000, -- default format timeout
    },
    config = {
      lua_ls = {
        settings = {
          Lua = {
            hint = {
              enable = true,
              arrayIndex = "Disable",
            },
          },
        },
      },
      html = { init_options = { provideFormatter = false } },
      cssls = { init_options = { provideFormatter = false } },
    },
    servers = {
      "lua_ls",
      "eslint",
      "vtsls",
      "jsonls",
      "html",
      "cssls",
      "emmet_ls",
      "docker-language-server",
      "nixd",
    },
  },
}

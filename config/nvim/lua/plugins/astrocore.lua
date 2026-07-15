---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    filetypes = {
      extension = {
        pcss = "postcss",
        postcss = "postcss",
      },
      filename = { ["docker-compose.yaml"] = "yaml.docker-compose" },
    },
    treesitter = {
      auto_install = true,
      ensure_installed = {
        "lua",
        "luap",
        "nix",
        "javascript",
        "typescript",
        "tsx",
        "jsdoc",
        "html",
        "css",
        "scss",
        "json",
        "styled",
        "dockerfile",
      },
    },
  },
}

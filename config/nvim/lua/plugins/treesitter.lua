return {
  "nvim-treesitter/nvim-treesitter",
  opts = function() vim.treesitter.language.register("scss", { "less", "postcss" }) end,
}

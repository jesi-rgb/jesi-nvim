return {
  -- disabled plugins
  { "rcarriga/nvim-notify", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "echasnovski/mini.indentscope", enabled = false },
  { "ggandor/leap.nvim", enabled = false },

  -- enabled or configured plugins
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  { "rose-pine/neovim", name = "rose-pine", opts = { disable_italics = true, disable_background = true } },
  { "ThePrimeagen/harpoon" },
  { "nvim-telescope/telescope.nvim" },
  { "sbdchd/neoformat" },
  { "leafOfTree/vim-matchtag" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}

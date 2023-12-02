return {
  -- disabled plugins
  { "rcarriga/nvim-notify", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "echasnovski/mini.indentscope", enabled = false },
  { "ggandor/leap.nvim", enabled = false },
  { "ggandor/flit.nvim", enabled = false },

  -- enabled or configured plugins
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = { disable_italics = true, disable_background = true },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { flavour = "mocha", color_overrides = { mocha = { base = "#202029" } } },
  },

  { "ThePrimeagen/harpoon" },
  { "nvim-telescope/telescope.nvim" },
  { "sbdchd/neoformat" },
  { "leafOfTree/vim-matchtag" },

  { "sheerun/vim-polyglot" },
  { "othree/html5.vim" },
  { "pangloss/vim-javascript" },
  { "evanleck/vim-svelte" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}

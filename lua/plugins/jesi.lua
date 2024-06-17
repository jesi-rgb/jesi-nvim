return {
  -- disabled plugins
  { "rcarriga/nvim-notify", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "akinsho/bufferline.nvim", enabled = false },
  { "echasnovski/mini.indentscope", enabled = false },
  { "ggandor/leap.nvim", enabled = false },
  { "ggandor/flit.nvim", enabled = false },
  -- { "stevearc/dressing.nvim", enabled = false },
  -- { "folke/noice.nvim", enabled = false },
  -- { "MunifTanjim/nui.nvim", enabled = false },

  -- enabled or configured plugins
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
    opts = { disable_background = true },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = { flavour = "auto" },
  },

  { "adalessa/laravel.nvim" },
  { "ThePrimeagen/harpoon" },
  { "nvim-telescope/telescope.nvim" },
  { "sbdchd/neoformat" },
  { "leafOfTree/vim-matchtag" },

  { "folke/flash.nvim", modes = {
    char = {
      enabled = false,
    },
  } },

  { "prettier/vim-prettier" },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  { "chrisbra/Colorizer" },

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

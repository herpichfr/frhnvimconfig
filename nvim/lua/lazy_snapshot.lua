return {
  { "AstroNvim/astrotheme", optional = true },
  { "JoosepAlviste/nvim-ts-context-commentstring", optional = true },
  { "L3MON4D3/LuaSnip", build = "make install_jsregexp", optional = true },
  { "MunifTanjim/nui.nvim", optional = true },
  { "NMAC427/guess-indent.nvim", optional = true },
  { "NvChad/nvim-colorizer.lua", optional = true },
  { "Shatur/neovim-session-manager", optional = true },
  { "akinsho/toggleterm.nvim", optional = true },
  { "b0o/SchemaStore.nvim", optional = true },
  { "famiu/bufdelete.nvim", optional = true },
  { "folke/lazy.nvim", optional = true },
  { "folke/neodev.nvim", optional = true },
  { "folke/which-key.nvim", optional = true },
  { "goolord/alpha-nvim", optional = true },
  { "hrsh7th/cmp-buffer", optional = true },
  { "hrsh7th/cmp-nvim-lsp", optional = true },
  { "hrsh7th/cmp-path", optional = true },
  { "hrsh7th/nvim-cmp", optional = true },
  { "jay-babu/mason-null-ls.nvim", optional = true },
  { "jay-babu/mason-nvim-dap.nvim", optional = true },
  { "jose-elias-alvarez/null-ls.nvim", optional = true },
  { "kevinhwang91/nvim-ufo", optional = true },
  { "kevinhwang91/promise-async", optional = true },
  { "lewis6991/gitsigns.nvim", optional = true },
  { "lukas-reineke/indent-blankline.nvim", version = "v2.*" },
  { "max397574/better-escape.nvim", optional = true },
  { "mfussenegger/nvim-dap", optional = true },
  { "mrjones2014/smart-splits.nvim", optional = true },
  { "neovim/nvim-lspconfig", optional = true },
  { "numToStr/Comment.nvim", optional = true },
  { "nvim-lua/plenary.nvim", optional = true },
  { "nvim-neo-tree/neo-tree.nvim", optional = true },
  { "nvim-telescope/telescope-fzf-native.nvim", optional = true },
  { "nvim-telescope/telescope.nvim", optional = true },
  { "nvim-tree/nvim-web-devicons", optional = true },
  { "nvim-treesitter/nvim-treesitter", optional = true },
  { "onsails/lspkind.nvim", optional = true },
  { "rafamadriz/friendly-snippets", optional = true },
  { "rcarriga/cmp-dap", optional = true },
  { "nvim-neotest/nvim-nio" },
  { "rcarriga/nvim-dap-ui", optional = true },
  { "rcarriga/nvim-notify", optional = true },
  { "rebelot/heirline.nvim", optional = true },
  { "s1n7ax/nvim-window-picker", optional = true },
  { "saadparwaiz1/cmp_luasnip", optional = true },
  { "stevearc/aerial.nvim", optional = true },
  { "stevearc/dressing.nvim", optional = true },
  { "williamboman/mason-lspconfig.nvim", optional = true },
  { "williamboman/mason.nvim", optional = true },
  { "windwp/nvim-autopairs", optional = true },
  { "windwp/nvim-ts-autotag", optional = true },
  { "folke/tokyonight.nvim"},
  { "github/copilot.vim", event = "InsertEnter", lazy = false,
    config = function()
      vim.keymap.set('i', '<C-c>', function () return vim.fn['copilot#Accept']() end, { expr = true, silent = true })
    end
  },
  { 'davidgranstrom/nvim-markdown-preview' },
  { "LunarVim/bigfile.nvim" },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    lazy = true,
    config = function()
      vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-Tab>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-Shift-Tab>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
  },
--   {
--   "jackMort/ChatGPT.nvim",
--     event = "VeryLazy",
--     config = function()
--       require("chatgpt").setup( {
--         model = "gpt-3.5-turbo",
--         frequency_penalty = 0,
--         presence_penalty = 0,
--         max_tokens = 1000,
--         temperature = 0.7,
--         top_p = 1,
--         n = 1,
--       } )
--     end,
--     dependencies = {
--       "MunifTanjim/nui.nvim",
--       "nvim-lua/plenary.nvim",
--       "nvim-telescope/telescope.nvim"
--     }
-- }
  {
    {
      "nvim-neorg/neorg",
      build = ":Neorg sync-parsers",
      lazy = false, -- specify lazy = false because some lazy.nvim distributions set lazy = true by default
      -- tag = "*",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("neorg").setup {
          load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.itero"] = {},
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.dirman"] = { -- Manages Neorg workspaces
              config = {
                workspaces = {
                  index = "~/Dropbox/neorg",
                },
                default_workspace = "index",
              },
            },
            ["core.export"] = {},
            ["core.export.markdown"] = {
              config = {
                extensions = "all",
              },
            },
          },
        }
      end,
    },
  },
  {
    "vimwiki/vimwiki",
    event = "BufRead",
  },
{
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = false,  -- lazy loading
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/Dropbox/vaults/personal",
      },
      {
        name = "work",
        path = "~/Dropbox/vaults/work",
      },
    },

    -- see below for full list of options 👇
  },
  },
}

return {
  colorscheme = "astrotheme",

  plugins = {
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      config = function()
        require("catppuccin").setup {
          flavour = "latte", -- latte, frappe, macchiato, mocha
          background = { -- :h background
            light = "latte",
            dark = "mocha",
          },
          transparent_background = true, -- disables setting the background color.
          show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
          term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
          dim_inactive = {
            enabled = false, -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15, -- percentage of the shade to apply to the inactive window
          },
          no_italic = false, -- Force no italic
          no_bold = false, -- Force no bold
          no_underline = false, -- Force no underline
          styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
          },
          color_overrides = {},
          custom_highlights = {},
          integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            telescope = true,
            notify = false,
            mini = false,
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
          },}
      end,
    },

    {
      "AstroNvim/astrotheme",
      name = "astrotheme",
      priority = 1000,
      config = function()
        require("astrotheme").setup({
          palette = "astrodark", -- String of the default palette to use when calling `:colorscheme astrotheme`

          termguicolors = true, -- Bool value, toggles if termguicolors are set by AstroTheme.

          transparent_background = true, -- disables setting the background color.
          terminal_color = true, -- Bool value, toggles if terminal_colors are set by AstroTheme.

          plugin_default = "auto", -- Sets how all plugins will be loaded
                                   -- "auto": Uses lazy / packer enabled plugins to load highlights.
                                   -- true: Enables all plugins highlights.
                                   -- false: Disables all plugins.

          plugins = {              -- Allows for individual plugin overides using plugin name and value from above.
            ["bufferline.nvim"] = false,
          },

          palettes = {
            global = {             -- Globaly accessible palettes, theme palettes take priority.
              my_grey = "#ebebeb",
              my_color = "#ffffff"
            },
            astrodark = {          -- Extend or modify astrodarks palette colors
              red = "#800010",      -- Overrides astrodarks red color
              my_color = "#000000" -- Overrides global.my_color
            },
          },

          highlights = {
            global = {             -- Add or modify hl groups globaly, theme specific hl groups take priority.
              modify_hl_groups = function(hl, c)
                hl.PluginColor4 = {fg = c.my_grey, bg = c.none }
              end,
              ["@String"] = {fg = "#ff00ff", bg = "NONE"},
            },
            astrodark = {
              -- first parameter is the highlight table and the second parameter is the color palette table
              modify_hl_groups = function(hl, c) -- modify_hl_groups function allows you to modify hl groups,
                hl.Comment.fg = c.my_color
                hl.Comment.italic = true
              end,
              ["@String"] = {fg = "#ff00ff", bg = "NONE"},
            },
          },
        })  
      end,
    },
  },
}

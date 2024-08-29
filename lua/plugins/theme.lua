return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    dependencies = {},
    config = function()
      require("tokyonight").setup({
        on_highlights = function(highlight, color)
          highlight["@neorg.headings.5.prefix.norg"]={
            fg = "#2c8217",
          }
          highlight["@neorg.headings.5.prefix"]={
            fg = "#2c8217",
          }
          highlight["@neorg.headings.5.title.norg"]={
            fg = "#2c8217",
          }
          highlight["@neorg.headings.5.title"]={
            fg = "#2c8217",
          }
          highlight["@script"] = {
            fg = "#bb8ade",
          }
          highlight["@relationship"] = {
            fg = "#abcdef",
          }
          highlight["@others"] = {
            fg = "#123456",
          }
          highlight["@mathfont"] = {
            fg = "#f59090",
          }
          highlight["@symbol"] = {
            fg = "#44ff44",
          }
          highlight.Function = {
            fg = "#e49ef2",
          }
          highlight["@markup.math"] = "MathZone"
          highlight.MathZone = {
            fg = "#c1de73",
          }
          highlight["@operator"] = "Operator"
          highlight["@hugeoperator"] = "Operator"
          highlight.Operator = {
            fg = "#68e8d7",
          }
          highlight["@punctuation.bracket"] = {
            --fg = "#d8b37c"
            fg = "#73dec1",
          }
          highlight["@label"] = {
            --fg ="#1281cb"
            fg = "#7385f9",
          }
          highlight["@none"] = {
            fg = "#a9b1d6",
          }
          highlight["@breaket"] = {
            fg = "#aa88bb",
          }
          highlight["@blueColor"] = {
            fg = "#397fbf",
            --purple #a14fe0
            --pink #e04fd4
          }
          highlight["@purpleColor"] = {
            fg = "#a14fe0",
          }
          highlight["@redColor"] = {
            fg = "#e04fd4",
          }
          highlight["@greenColor"] = {
            fg = "#4fe0b5",
          }
        end,
      })
      vim.cmd([[colorscheme tokyonight-storm]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      "folke/tokyonight.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      vim.o.laststatus = vim.g.lualine_laststatue
      return {
        options = {
          globalstatus = vim.o.laststatus == 3,
          theme = "tokyonight",
          disabled_filetypes = { statusline = { "dashboard", "ministarter" } },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = {
      "folke/tokyonight.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = "tokyonight",
    },
  },
  {
    "SmiteshP/nvim-navic",
    event = "VeryLazy",
    dependencies = {
      "folke/tokyonight.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
  {
    "uga-rosa/ccc.nvim",
    keys = {
      { "<leader>oc", "<cmd>CccPick<cr>", desc = "Open Color Picker" },
    },
    config = true,
  },
  {
    "norcalli/nvim-terminal.lua",
    ft = "terminal",
    config = function()
      require("terminal").setup({})
    end,
  },
}

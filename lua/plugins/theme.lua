return {
  {
    "folke/tokyonight.nvim",
    priority=1000,
    dependencies = {
      "nvim-lualine/lualine.nvim",
      "nvim-tree/nvim-web-devicons",
      "utilyre/barbecue.nvim",
      "SmiteshP/nvim-navic",
    },
    config = function()
      require("tokyonight").setup({
        on_highlights=function (highlight,color)
          highlight["@mathfont"]={
            fg = "#ff4444"
          }
          highlight["@mathgreek"]={
            fg="#44ff44"
          }
          highlight.Function={
            fg="#e49ef2",
          }
          highlight["@markup.math"]="MathZone"
          highlight.MathZone={
            fg="#9ece6a",
          }
          highlight["@operator"]="Operator" 
          highlight.Operator={
            fg="#00ffbb"
          }
          highlight["@punctuation.bracket"] = {
            fg = "#d8b37c"
          }
          highlight["@label"]= {
            --fg ="#1281cb"
            fg = "#7385f9"
          }
          highlight["@none"]={
            fg="#a9b1d6"
          }
        end
      })
      vim.cmd[[colorscheme tokyonight-storm]]
      require('lualine').setup({
        options = {
          theme = 'tokyonight'
        },
      })
      require('barbecue').setup {
        theme = 'tokyonight',
      }
    end
  },
}

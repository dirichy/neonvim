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
          highlight["@script"]={
            fg="#bb8ade",
          }
          highlight["@relationship"]={
            fg="#abcdef"
          }
          highlight["@others"]={
            fg="#123456"
          }
          highlight["@mathfont"]={
            fg = "#f59090"
          }
          highlight["@mathgreek"]={
            fg="#44ff44"
          }
          highlight.Function={
            fg="#e49ef2",
          }
          highlight["@markup.math"]="MathZone"
          highlight.MathZone={
            fg="#c1de73",
          }
          highlight["@operator"]="Operator" 
          highlight.Operator={
            fg="#68e8d7",
          }
          highlight["@punctuation.bracket"] = {
            --fg = "#d8b37c"
            fg = "#73dec1",

          }
          highlight["@label"]= {
          --fg ="#1281cb"
            fg = "#7385f9"
          }
          highlight["@none"]={
            fg="#a9b1d6"
          }
          highlight["@breaket"]={
            fg="#aa88bb"
          }
            highlight["@blueColor"]={
            fg="#397fbf"
            --purple #a14fe0
            --pink #e04fd4
          }
            highlight["@purpleColor"]={
            fg="#a14fe0"
          }
            highlight["@redColor"]={
            fg="#e04fd4"
          }
            highlight["@greenColor"]={
            fg="#4fe0b5"
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

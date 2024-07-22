return{
  {"dirichy/latex.nvim",
    lazy=false,
    config=function ()
      require("latex").setup()
    end
  },
  {
    "bamonroe/rnoweb-nvim",
    lazy=false,
    enabled=false,
    dependencies={
      "nvim-lua/plenary.nvim"
    },
    config=true,
  }
}

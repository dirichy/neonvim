return {
  "nvim-neorg/neorg",
  ft = "norg",
  cmd = "Neorg",
  version = "*",
  config = function()
    require("neorg").setup {
      load = {
        ["core.defaults"] = {},
        ["core.summary"] = {
          config={
            strategy = "default"
          }
        },
        ["core.concealer"] = {
          config = {
            icons = {
              heading={
                icons={
                  "☘",
                  "󰄛",
                  "✿",
                  "",
                  "󱁕",
                  "󰧱",
                },
              },
              ordered={
                icons={
                  "1.",
                  "1)",
                  "A.",
                  "A)",
                  "a.",
                  "a)",
                },
              },
            }
          }
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
        ["core.qol.todo_items"] = {
          config={
            create_todo_items = true,
            create_todo_parents = true,
          }
        }
      },
    }
    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
}

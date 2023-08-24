-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Color preview for working with hex colors
  {'rrethy/vim-hexokinase'},
  -- Theming / add themes here change from init.lua
  {'sainnhe/sonokai'},
  {'folke/tokyonight.nvim'},

  --Status line
  {'vim-airline/vim-airline'},
  {'vim-airline/vim-airline-themes'},

  {'github/copilot.vim'},

  { "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      require('neo-tree').setup {
        window = {
          position = "left",
          width = 22,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
        }
      }
    end,
  }
}-- add neotree

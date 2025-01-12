-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- MOVE STUFF
  {'matze/vim-move'},
  -- Color preview for working with hex colors
  {'rrethy/vim-hexokinase'},
  -- Theming / add themes here change from init.lua
  {'sainnhe/sonokai'},
  {'folke/tokyonight.nvim'},
  --Status line
  {'vim-airline/vim-airline'},
  {'vim-airline/vim-airline-themes'},
  -- Copilot
  -- {'github/copilot.vim'},
  -- Neo tree
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
  },
  -- Startup screen
  {
    "startup-nvim/startup.nvim",
    requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
    config = function()
      require"startup".setup({
        header = {
          type = "text",
          oldfiles_directory = true,
          align = "center",
          fold_section = false,
          title = "Header",
          margin = 0,
          content = {
            "████████╗██████╗  █████╗  ██████╗ ██████╗  █████╗ ████████╗███████╗",
            "╚══██╔══╝██╔══██╗██╔══██╗██╔════╝ ██╔══██╗██╔══██╗╚══██╔══╝██╔════╝",
            "   ██║   ██████╔╝███████║██║  ███╗██║  ██║███████║   ██║   █████╗  ",
            "   ██║   ██╔══██╗██╔══██║██║   ██║██║  ██║██╔══██║   ██║   ██╔══╝  ",
            "   ██║   ██║  ██║██║  ██║╚██████╔╝██████╔╝██║  ██║   ██║   ███████╗",
            "   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝",

          },
          highlight = "Statement",
          default_color = "",
          oldfiles_amount = 0,
        },
        -- name which will be displayed and command
        body = {
          type = "mapping",
          oldfiles_directory = false,
          align = "center",
          fold_section = false,
          title = "Basic Commands",
          margin = 0,
          content = {
            { " Find File", "Telescope find_files", "<leader>ff" },
            { " Find Word", "Telescope live_grep", "<leader>lg" },
            { " Recent Files", "Telescope oldfiles", "<leader>of" },
            { " File Browser", "Telescope file_browser", "<leader>fb" },
            { " Colorschemes", "Telescope colorscheme", "<leader>cs" },
            { " New File", "lua require'startup'.new_file()", "<leader>nf" },
          },
          highlight = "String",
          default_color = "",
          oldfiles_amount = 0,
        },
        footer = {
          type = "text",
          oldfiles_directory = false,
          align = "center",
          fold_section = false,
          title = "Footer",
          margin = 0,
          content = { "tragdate.ninja" },
          highlight = "Number",
          default_color = "",
          oldfiles_amount = 0,
        },

        options = {
          mapping_keys = true,
          cursor_column = 0.5,
          empty_lines_between_mappings = true,
          disable_statuslines = true,
          paddings = { 8, 4, 2, 10 },
        },
        mappings = {
          execute_command = "<CR>",
          open_file = "o",
          open_file_split = "<c-o>",
          open_section = "<TAB>",
          open_help = "?",
        },
        colors = {
          background = "#1f2227",
          folded_section = "#0069ff",
        },
        parts = { "header", "body", "footer" },
      })   end
  },
  {
    'Exafunction/codeium.vim',
    config = function ()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true })
      vim.keymap.set('i', '<c-n>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
      vim.keymap.set('i', '<c-p>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
      vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
    end
  }
}

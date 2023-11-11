-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--



vim.g.mapleader = ' '
vim.keymap.set({ 'n', 't' }, '<C-t>', '<C-\\>', { remap = true })
vim.keymap.set('n', '<leader>|', ':vs<cr>', { silent = true })
vim.keymap.set('n', '<leader>-', ':sp<cr>', { silent = true })
lvim.builtin.which_key.ignore_dirs = {}

vim.opt.relativenumber = true;


lvim.keys.normal_mode["<leader>v"] = ":vsplit<cr>"
lvim.keys.normal_mode["<leader>-"] = ":split<cr>"
lvim.keys.normal_mode["dd"] = { '"_dd', silent = true }
lvim.keys.visual_mode["d"] = { '"_d', silent = true }
lvim.keys.normal_mode["d"] = { '"_d', silent = true }
lvim.keys.visual_mode["<leader>lf"] = { vim.lsp.buf.format }
lvim.keys.visual_mode["<leader>sp"] = {":Telescope project<CR>"}
---@param extension string
local function open(extension)
  return function()
    local path = vim.api.nvim_buf_get_name(0)
    local dir = vim.fs.dirname(path)
    local filename = path:match('.*/(.-)%.')

    vim.cmd(('edit %s/%s.%s'):format(dir, filename, extension))
  end
end

lvim.builtin.which_key.mappings["o"] = { "<cmd>:echo 'Open related file'<CR>", "Open related file" }
lvim.keys.normal_mode["<leader>om"] = { open('module.ts'),  {silent = true, desc = 'Open module file'}};
lvim.keys.normal_mode["<leader>os"] = { open('component.scss') , {silent = true, desc = 'Open styles file'}};
lvim.keys.normal_mode["<leader>ol"] = { open('component.ts') , {silent = true, desc = 'Open logic file'}};
lvim.keys.normal_mode["'<A-up>"] = {'ddkP'};
lvim.keys.normal_mode["'<A-down>"] = {'ddp'};
lvim.builtin.telescope.defaults.mappings.i["<C-f>"] = require'telescope.actions'.to_fuzzy_refine


lvim.builtin.nvimtree.setup.renderer.icons.glyphs.git.deleted = "D"
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.git.ignored = "I"
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.git.renamed = "R"
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.git.staged = "A"
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.git.unmerged = "M"
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.git.unstaged = "M"
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.git.untracked = "U"
lvim.builtin.nvimtree.setup.filters.custom = {}

lvim.plugins = {
  {
    'b0o/schemastore.nvim',
    config = function()
      local opts = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      }
      require('lvim.lsp.manager').setup('jsonls', opts)
    end
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-telescope/telescope-project.nvim' },
  {
    'sindrets/diffview.nvim'
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    'axelvc/template-string.nvim',
    config = function()
      require('template-string').setup {
        remove_template_string = true,

      }
    end
  }
}

require("lvim.lsp.manager").setup("angularls")
require("lvim.lsp.manager").setup("emmet_ls")

lvim.builtin.telescope.defaults.file_ignore_patterns = { 'node_modules' }
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(telescope.load_extension, 'fzf')
end
lvim.autocommands = {
  {
    { "ColorScheme" },
    {
      pattern = "*",
      callback = function()
        -- change `Normal` to the group you want to change
        -- and `#ffffff` to the color you want
        -- see `:h nvim_set_hl` for more options
        vim.cmd([[highlight DiffAdd guibg=#373D2B]])
        vim.cmd([[highlight DiffDelete guibg=#4D191E]])
        vim.api.nvim_set_hl(0, "Label1", { fg = "#ffbe00" })
      end,
    },
  },
}

local formatters = require("lvim.lsp.null-ls.formatters")



formatters.setup({
  { name = "prettierd" },
  filetypes = {
    "css",
    "html",
    "javascriptreact",
    "scss",
    "typescriptreact",
    "javascript",
    "typescript",
  },
})

lvim.builtin.alpha.dashboard.section.header.opts.hl = "Label1"
lvim.autocommands = {
  {
    { "ColorScheme" },
    {
      pattern = "*",
      callback = function()
        -- change `Normal` to the group you want to change
        -- and `#ffffff` to the color you want
        -- see `:h nvim_set_hl` for more options
        vim.cmd([[highlight DiffAdd guibg=#373D2B]])
        vim.cmd([[highlight DiffDelete guibg=#4D191E]])
        vim.api.nvim_set_hl(0, "Label1", { fg = "#ffbe00" })
      end,
    },
  },

  -- {
  --   { "CmdlineEnter" },
  --   {
  --     pattern = "*",
  --     callback = function()
		-- 		vim.opt.ignorecase = false
  --     end,
  --   },
  -- },
  -- {
  --   { "CmdlineLeave" },
  --   {
  --     pattern = "*",
  --     callback = function()
		-- 		vim.opt.ignorecase = true
  --     end,
  --   },
  -- },
}
lvim.builtin.alpha.dashboard.section.header.val = {
[[]],
[[]],
[[]],
[[]],
[[]],
[[]],
[[]],
[[]],
[[██████╗ ███████╗ ██████╗  ██████╗ ]],
[[██╔══██╗██╔════╝██╔════╝ ██╔═══██╗]],
[[██████╔╝█████╗  ██║  ███╗██║   ██║]],
[[██╔══██╗██╔══╝  ██║   ██║██║   ██║]],
[[██████╔╝███████╗╚██████╔╝╚██████╔╝]],
[[╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ ]],
[[]],
[[]],
[[]],
[[]],
[[]],
[[]],
[[]],
[[]],
}
-- lvim.builtin.nvimtree = {

-- }
--
-- lvim.builtin.nvimtree.setup({
--   event_handlers = {
--          {
--             event = "file_opened",
--             handler = function(file_path)
--               -- auto close
--               -- vimc.cmd("Neotree close")
--               -- OR
--               require("neo-tree.command").execute({ action = "close" })
--             end
--           }, 
--   }
-- })

-- lvim.builtin.nvimtree.setup.actions.op-- lvim.builtin.nvimtree = {
--   active = true, -- Set this to true to enable Neotree
--   on_config_done = nil, -- A function you can define to run after setup is done
--   view = {
--     side = "left", -- Neotree position (left or right)
--     width = 40, -- Neotree width
--     auto_resize = true, -- Automatically resize Neotree when opening or closing it
--   },
-- }

lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true

vim.opt.title = true
local root_dir = vim.fn.expand('%:p:h:t') -- convert "foo/bar/etc" into "etc"
vim.opt.titlestring = (' %s'):format(root_dir)

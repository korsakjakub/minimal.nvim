local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require('lazy').setup({
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "jayp0521/mason-nvim-dap.nvim" },
    { 'neovim/nvim-lspconfig' },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.4', dependencies = { 'nvim-lua/plenary.nvim' } },
    { "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = { "lua", "vim", "vimdoc", "java", "typescript", "javascript", "html" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },  
            }) end},
    {'theprimeagen/harpoon'},
    {'mbbill/undotree'},
    {'tpope/vim-fugitive'},
    {'mfussenegger/nvim-jdtls'},
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = { }
    },
    {'hrsh7th/nvim-cmp'}
})
require('mason').setup()


vim.cmd.colorscheme 'catppuccin'


-- options
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')
vim.opt.updatetime = 50
vim.g.mapleader = ' '

-- remaps & plugin settings
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('v', 'K', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('x', '<leader>p', '\"_dP')
vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>y', '\"+y')
vim.keymap.set('n', '<leader>Y', '\"+Y')
vim.keymap.set('n', '<leader>d', '\"_d')
vim.keymap.set('v', '<leader>d', '\"_d')
vim.keymap.set('n', 'Q', '<nop>')

-- which key
local wk = require('which-key')

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
wk.register({
    p = {
        name = 'Fuzzy find',
        f = { builtin.find_files, 'Fuzzy find files'},
        s = {function() builtin.grep_string({ search = vim.fn.input('Grep > ') }) end, 'Fuzzy find in Git'}
    }
}, {prefix = '<leader>'})

-- harpoon
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)
vim.keymap.set('n', '<C-h>', function() ui.nav_file(1) end)
vim.keymap.set('n', '<C-j>', function() ui.nav_file(2) end)
vim.keymap.set('n', '<C-k>', function() ui.nav_file(3) end)
vim.keymap.set('n', '<C-l>', function() ui.nav_file(4) end)

wk.register({
    a = { mark.add_file, 'Harpoon add file'}
}, {prefix = '<leader>'})

-- undotree
wk.register({
    u = { vim.cmd.Git, 'UndoTree'}
}, {prefix = '<leader>'})

-- fugitive
-- vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
wk.register({
    gs = { vim.cmd.Git, 'Git'}
}, {prefix = '<leader>'})

-- jdtls
local jd = require('jdtls')
-- vim.keymap.set('n', '<leader>jo', function() jd.organize_imports() end) -- Organize imports

wk.register({
    j = {
        name = 'java',
        o = { function() jd.organize_imports() end , 'Organize Imports'},
        e = { function() jd.extract_variable() end , 'Extract Variable'},
        c = { function() jd.extract_constant() end , 'Extract Constant'},
        m = { function() jd.extract_method() end , 'Extract Method'},
        t = { function() jd.test_class() end, 'Test Class'},
    }
}, {prefix = '<leader>'})

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer = require('packer')
return packer.startup(function()
  use 'wbthomason/packer.nvim'
  use {
    'w0rp/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  use {
    's1n7ax/nvim-terminal',
    config = function()
      vim.o.hidden = true
      require('nvim-terminal').setup()
    end,
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }
  use 'liuchengxu/vista.vim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use { 'hrsh7th/nvim-cmp',
  requires = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'saadparwaiz1/cmp_luasnip',
  },
}
use "lewis6991/impatient.nvim"
use "joshdick/onedark.vim"
use "cocopon/iceberg.vim"
use "savq/melange"
use {'junegunn/fzf', dir =  '~/.fzf', run = './install --all' }
use 'junegunn/fzf.vim'
use 'kyazdani42/nvim-web-devicons'
use "b0o/schemastore.nvim"
use 'jose-elias-alvarez/null-ls.nvim'
use 'nvim-lua/plenary.nvim'
use 'jose-elias-alvarez/nvim-lsp-ts-utils'

use 'folke/lua-dev.nvim' -- better sumneko_lua settings
use { 'RRethy/vim-illuminate',  as = 'illuminate' } -- highlights and allows moving between variable references
if packer_bootstrap then
  require('packer').sync()
end
end)



"####################
"      Plugins
"####################
call plug#begin()
Plug 'stevearc/aerial.nvim'
Plug 'kazhala/close-buffers.nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-path'
Plug 'chrisbra/colorizer'
Plug 'numToStr/Comment.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'] }
Plug 'mhartington/formatter.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'phaazon/hop.nvim'
Plug 'smjonas/inc-rename.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'onsails/lspkind.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'alvarosevilla95/luatab.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'chentoast/marks.nvim'
Plug 'valloric/matchtagalways'
Plug 'windwp/nvim-autopairs'
Plug 'kevinhwang91/nvim-bqf'
Plug 'mfussenegger/nvim-lint'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-ts-autotag'
Plug 'nvim-treesitter/playground'
Plug 'nvim-lua/plenary.nvim'
Plug 'majutsushi/tagbar'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
Plug 'tpope/vim-fugitive'
Plug 'rhysd/git-messenger.vim'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-repeat'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'qpkorr/vim-bufkill'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nordtheme/vim'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()
"########################################"

"########################################"
"            General Settings
"########################################"
" Leader
let mapleader=','

" Map source neovim config
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Enable filetype plugins and indent
filetype plugin indent on

" Clipboard
vnoremap <C-c> "+y

" Syntax highlighting
syntax on

" Visual wrapping
set linebreak
set breakindent

" Mouse
set mouse=a

" Line numbers
set number relativenumber
set cursorline
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber cursorline
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber nocursorline
augroup END

" Map escape key
:inoremap jj <Esc>

" Split
set splitbelow
set splitright
nnoremap <leader>ws <C-w>s
nnoremap <leader>wv <C-w>v

" Tabs
nnoremap tn :tabnew<Space>
nnoremap tk :tabnext<CR>
nnoremap tj :tabprev<CR>
nnoremap tp :tabclose<CR>
nnoremap gw :Window<CR>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
nnoremap tl :exe "tabn ".g:lasttab<cr>

" Set lasttab
augroup tableave
  autocmd!
  autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END

" Indentation
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent

" Paste without auto indentation
nnoremap <silent> <leader>p :set paste<CR>"*p:set nopaste<CR>"

" Buffer
set hidden
nnoremap gp :bp<CR>
nnoremap gn :bn<CR>
"nnoremap gd :BD<CR>

" String encoding
set encoding=utf8

" Disable search highlight
set nohlsearch

" Change cursor between modes
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"

" Don't wrap text when typing
set formatoptions-=t

" Allow backspace for indents and newline
set backspace=indent,eol,start

" Fold
augroup Fold
  autocmd!
  autocmd BufWinEnter * normal zR
augroup END
"

" Location list
nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lc :lclose<CR>

" Quickfix list
nnoremap <leader>qo :copen<CR>
nnoremap <leader>qc :cclose<CR>

" Color scheme
set termguicolors " True color support (https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6)
colorscheme nord

" Global statusline
set laststatus=3

" Winbar
set winbar=%=%m\ %f

" Help
noremap <leader>hv :vert help<Space>
"########################################"

"########################################"
"            Plugin Settings
"########################################"
" Colorizer
nnoremap <leader>ct :ColorToggle<CR>

" Emmet
let g:user_emmet_leader_key='<C-Z>'
let g:user_emmet_mode='a'

" Markdown Preview
let g:mkdp_theme = 'light'

" Nord-vim
let g:nord_cursor_line_number_background = 1

" Nvim-tree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader><C-n> :NvimTreeFindFile<CR>
nnoremap <leader>fn :NvimTreeFocus<CR>

" Tagbar
nnoremap tg :TagbarToggle<CR>

" Telescope
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader><C-p> :call<Space>git#ListFiles()<CR>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap gb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" Treesitter
nnoremap <leader>to :TSBufEnable highlight<CR>
nnoremap <leader>tf :TSBufDisable highlight<CR>

" {{{ Vim-fugitive
nnoremap <leader>gdv :Gvdiffsplit!<CR>
nnoremap <leader>gdh :diffget //2<CR>
vnoremap <leader>gdh :diffget //2<CR>
nnoremap <leader>gdl :diffget //3<CR>
vnoremap <leader>gdl :diffget //3<CR>
nnoremap <leader>gdg :diffget<CR>
nnoremap <leader>gdp :diffput<CR>
nnoremap <leader>gv :Gvdiff<CR>
nnoremap <leader>gs :tab G<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>ge :tabnew<CR>:Gedit<Space>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :tabnew<CR>:Gclog<CR>
nnoremap <leader>ogl :tabnew<Space>%<CR>:0Gclog<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :terminal git push<CR>
nnoremap <leader>gpl :terminal git pull<CR>

augroup Fugitive
  autocmd!

  " Map '..' to open parent tree.
  autocmd User fugitive
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif

  " Auto-clean fugitive buffers.
  autocmd BufReadPost fugitive://* set bufhidden=delete
augroup END
" }}}

" Vim-multiple-cursors
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<C-m>'
let g:multi_cursor_select_all_word_key = '<A-m>'
let g:multi_cursor_start_key           = 'g<C-m>'
let g:multi_cursor_select_all_key      = 'g<A-m>'
let g:multi_cursor_next_key            = '<C-m>'
let g:multi_cursor_prev_key            = '<C-[>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" Vim-startify
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']        },
      \ { 'type': 'files',     'header': ['   Files']             },
      \ { 'type': 'dir',       'header': ['   Current directory '. getcwd()]  },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']       },
      \ { 'type': 'commands',  'header': ['   Commands']        },
      \ ]
"########################################"

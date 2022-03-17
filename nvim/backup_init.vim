let mapleader = ","
" Such emacs
nnoremap <Space><Space> :Files<Cr>
nnoremap <leader>d :ALEGoToDefinitionInSplit<cr>


" set termguicolors
let g:tokyonight_style = "night"
set background=dark
colorscheme tokyonight

inoremap jj <ESC>
nnoremap <C-J> <C-W>j
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
nnoremap <C-K> <C-W>k

nnoremap <cr> :nohlsearch<cr>
nnoremap <C-B> :BufExplorer<cr>

" LOL such dedication
map <UP> ""
map <DOWN> ""
map <LEFT> ""
map <RIGHT> ""


set vb t_vb=               " Turn off beep
set lazyredraw             " Don't redraw during macro execution
set synmaxcol=2048         " Stop syntax highlighting for long lines
set number
set nowrap                 " No wrapping by default
set scrolloff=4            " Keep a few lines above and below current line
set equalalways            " create equally sized splits
set splitbelow splitright  " split placement
set wildmode=longest,list  " Makes completion in command mode like bash
set history=1000           " Keep a lot of stuff in history
set nobackup               " Make backups
set undofile               " Keep undo history even after closing Vim
set undodir=~/.local/share/nvim/undo    " Where to store undo history
set timeoutlen=500         " Don't wait so long for ambiguous leader keys
set gdefault               " assume the /g flag on :s substitutions to replace all matches in a line
set colorcolumn=80
set linespace=5

" Indenting always 2 spaces, sorry Python
set cindent
set expandtab
set shiftwidth=2
set smartindent
set softtabstop=2
set tabstop=2

" Search
set smartcase
set hlsearch
set wildignore+=**/tmp

cnoreabbrev E e
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev WQ wq
cnoreabbrev Wq wq

" %% will become the directory of the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" Hooks up smart tab autocomplete behavior mentioned above
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
let g:mix_format_on_save = 1
let g:mix_format_silent_errors = 1

let g:ale_linters = {'haskell': ['hlint', 'ghc']}
let g:ale_haskell_ghc_options = '-fno-code -v0 -isrc'

let g:airline_theme='monochrome'


" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx'],
        \ })
endif

" Smart tab autocomplete behavior
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction


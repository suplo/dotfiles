let mapleader = "\<Space>"

" Plugins will be downloaded under the specified directory
call plug#begin('~/.local/share/nvim/plugged')

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kien/ctrlp.vim'

Plug 'mileszs/ack.vim'

Plug 'ciaranm/securemodelines'
Plug 'justinmk/vim-sneak'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

" GUI enhancements
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'andymass/vim-matchup'

" Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Test runner
Plug 'janko/vim-test'

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
Plug 'fatih/vim-go'
Plug 'dag/vim-fish'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'vim-ruby/vim-ruby'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'

Plug 'morhetz/gruvbox'

" List ends here. Plugins become visible to neovim after this call.
call plug#end()

nnoremap :W :w
nnoremap ff :FZF

" Map vim-test's :TestNearest with :tt
nnoremap tt :TestNearest
nnoremap tf :TestFile


" Set tabstop
set tabstop=2 shiftwidth=2 expandtab

" Colors
set background=dark
colorscheme gruvbox

set colorcolumn=120 " Show vertical line at column 120
set number " Also show current absolute line
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals

" Show underline at current cursor
hi clear CursorLine
hi CursorLine gui=underline cterm=underline
set cursorline

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" Highlight and trim trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set guioptions-=T " Remove toolbar
set ttyfast
set lazyredraw

" Use old version of regex engine to speed up vim
set re=1

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
endif

" Replace ack by ag
let g:ackprg = 'ag --vimgrep --smart-case'
cnoreabbrev ag Ack
cnoreabbrev aG Ack
cnoreabbrev Ag Ack
cnoreabbrev AG Ack

" Map \ key to Ag (silver search)
nnoremap \ :Ack<space>

" Fix Shift-JIS file encoding issue
set fileencodings=ucs-bom,utf-8,sjis,default

" Quick save
nmap <leader>w :w<CR>

" Quick file open
nnoremap <Leader>o :CtrlP<CR>

" Make Ctrl-P plugin a lot faster for Git project
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif

" Quick back and forth buffer switching
nnoremap <Leader><Leader> :e#<CR>

" Quick copy & paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p

set encoding=utf-8
set backspace=indent,eol,start
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set ignorecase
set smartcase
set hlsearch
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
set incsearch
set scrolloff=8
set wrap
set linebreak
set cursorline
set showmatch
set wildmenu
set laststatus=2
set t_Co=256
syntax on
colorscheme default
highlight Normal         ctermfg=white ctermbg=none
highlight LineNr         ctermfg=59
highlight CursorLineNr   ctermfg=white
highlight CursorLine     ctermbg=236 cterm=none
highlight Visual         ctermbg=236
highlight Search         ctermfg=white ctermbg=67
highlight IncSearch      ctermfg=black ctermbg=white
highlight MatchParen     ctermfg=white ctermbg=67
highlight Pmenu          ctermfg=white ctermbg=236
highlight PmenuSel       ctermfg=white ctermbg=67
highlight StatusLine     ctermfg=white ctermbg=236 cterm=none
highlight StatusLineNC   ctermfg=59 ctermbg=236 cterm=none
highlight VertSplit      ctermfg=236 ctermbg=236
highlight Folded         ctermfg=59 ctermbg=236
highlight TabLine        ctermfg=59 ctermbg=236 cterm=none
highlight TabLineFill    ctermbg=236 cterm=none
highlight TabLineSel     ctermfg=white ctermbg=none cterm=none
highlight NonText        ctermfg=236
highlight SpecialKey     ctermfg=236
highlight ErrorMsg       ctermfg=white ctermbg=67
highlight WarningMsg     ctermfg=67
highlight Directory      ctermfg=67
highlight Title          ctermfg=white cterm=bold
highlight WildMenu       ctermfg=white ctermbg=67
highlight SignColumn     ctermbg=none
highlight SpellBad       ctermfg=white ctermbg=none cterm=underline
highlight SpellCap       ctermfg=67 ctermbg=none cterm=underline

highlight DiffAdd        ctermfg=white ctermbg=236
highlight DiffChange     ctermfg=67 ctermbg=236
highlight DiffDelete     ctermfg=59 ctermbg=236
highlight DiffText       ctermfg=white ctermbg=67

highlight Comment        ctermfg=59
highlight String         ctermfg=102
highlight Number         ctermfg=white
highlight Float          ctermfg=white
highlight Function       ctermfg=white
highlight Identifier     ctermfg=white
highlight Type           ctermfg=67
highlight Statement      ctermfg=67
highlight PreProc        ctermfg=67
highlight Constant       ctermfg=white
highlight Special        ctermfg=white
highlight Conditional    ctermfg=67
highlight Repeat         ctermfg=67
highlight Operator       ctermfg=white
highlight Keyword        ctermfg=67
highlight Exception      ctermfg=67
highlight Boolean        ctermfg=67
highlight Include        ctermfg=67
highlight Define         ctermfg=67
highlight StorageClass   ctermfg=67
highlight Structure      ctermfg=67
highlight Typedef        ctermfg=67
highlight Label          ctermfg=67
highlight Tag            ctermfg=white
highlight Delimiter      ctermfg=white
highlight Debug          ctermfg=59
highlight Underlined     ctermfg=67 cterm=underline
highlight Error          ctermfg=white ctermbg=67
highlight Todo           ctermfg=67 ctermbg=none cterm=bold


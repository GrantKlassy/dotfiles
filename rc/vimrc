" gklassy vim config file
" vim: set ft=vim:

""""""""""""""""""
" BASIC SETTINGS "
""""""""""""""""""

set number			" Line numbers on
colo elflord			" Color scheme
syntax on			" Syntax highlighting
set hlsearch			" Highlight search
set noet			" No 'expand tab'
set cursorline			" Cursor line
set ic				" Ignore case
set title			" Set the terminal tab title
set modeline			" Use modelines
set nofoldenable		" Don't fold lines of code

" Spelling
set spellfile=~/.vim/spell/en.utf-8.add
set spelllang=en
"set spell

""""""""""""""""
" SET FILETYPE "
""""""""""""""""

" Terraform files
autocmd BufNewFile,BufRead *.hcl set filetype=hcl
autocmd BufNewFile,BufRead *.nomad set filetype=hcl
autocmd BufNewFile,BufRead *.tf set filetype=hcl
autocmd BufNewFile,BufRead Appfile set filetype=hcl

" Yaml files
autocmd BufNewFile,BufRead *.yaml,*.yml,*.tmpl set filetype=yaml
autocmd BufNewFile,BufRead *kubeconfig set filetype=yaml nowrap
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Markdown files
autocmd BufNewFile,BufRead *.md set filetype=markdown

" cfengine2 files
autocmd BufNewFile,BufRead cf.* set filetype=cfengine

"""""""""""""""""""""""""""
" vim-plug PLUGIN MANAGER "
"""""""""""""""""""""""""""

" Start vim-plug from plugged
" call plug#begin('~/.vim/plugged')

" WHITESPACE
" Plug 'https://github.com/ntpeters/vim-better-whitespace'

" LIGHT LINE
" Plug 'https://github.com/itchyny/lightline.vim'
" set laststatus=2
" let g:lightline = {'colorscheme': 'jellybeans'}

" LINT CHECKING
"	Plug 'https://github.com/w0rp/ale'
"
" MARKDOWN TABLES
"	Plug 'https://github.com/dhruvasagar/vim-table-mode'
"
" GIT BRANCH
"	Plug 'https://github.com/itchyny/vim-gitbranch'
"
" INDENT GUIDES
"	Plug 'nathanaelkane/vim-indent-guides'
"	let g:indent_guides_guide_size = 1
"	let g:indent_guides_color_change_percent = 3
"
" MUSTACHE FORMATTING & SYNTAX
"	Plug 'https://github.com/mustache/vim-mustache-handlebars'

" List of vim-plug plugins ends here
" call plug#end()

""""""""""""""""""
" EXTRA SETTINGS "
""""""""""""""""""

" Vim. Don't indent my lines automatically. Please.
set nocindent
set nosmartindent
set noautoindent
set indentexpr=
filetype indent off
filetype plugin indent off

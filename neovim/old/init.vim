"     ____  __            _           
"    / __ \/ /_  ______ _(_)___  _____
"   / /_/ / / / / / __ `/ / __ \/ ___/
"  / ____/ / /_/ / /_/ / / / / (__  ) 
" /_/   /_/\__,_/\__, /_/_/ /_/____/  
"               /____/                
"

let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-plug initialization
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Specifying a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Basic
Plug 'vimwiki/vimwiki'
Plug 'cdelledonne/vim-cmake'
Plug 'tbabej/taskwiki'
Plug 'plasticboy/vim-markdown'
Plug 'tomasr/molokai'
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Language support+
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'voldikss/vim-floaterm'


" Initialize plugin system
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <c-t> :FloatermNew fff<cr>
let g:cmake_link_compile_commands = 1

nmap <leader>cg :CMakeGenerate<cr>
nmap <leader>cb :CMakeBuild<cr>
nmap <leader>gt :GTestRunUnderCursor<cr>

" autocmd VimEnter * NERDTree
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}

let g:ale_fixers = {
    \   'python': ['yapf'],
    \   'cpp': ['clang-format'],
    \   'c': ['clang-format']
    \}

let g:ale_linters = {
    \   'python': ['yapf'],
    \   'cpp': ['cc'],
    \   'c': ['clang'],
    \}

let g:ale_cpp_cc_options = '-I$CPLIB -I$ACLIB -std=c++20 -fcoroutines -Wall -Werror -Wextra -DDBG_MACRO_NO_WARNING'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fzf (fuzzy finder)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This is the default extra key bindings
let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-x': 'split',
\ 'ctrl-v': 'vsplit',
\ 'ctrl-o': ':r !g++ -E -P -nostdinc 2> /dev/null'}

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

map <C-f> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>


let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-vcs"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'Comment'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'Statement'],
\ 'info':    ['fg', 'PreProc'],
\ 'border':  ['fg', 'Ignore'],
\ 'prompt':  ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
\   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
let initial_command = printf(command_fmt, shellescape(a:query))
let reload_command = printf(command_fmt, '{q}')
let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
\ call fzf#vim#grep(
\   'git grep --line-number '.shellescape(<q-args>), 0,
\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)



"     ____             _     
"    / __ )____ ______(_)____
"   / __  / __ `/ ___/ / ___/
"  / /_/ / /_/ (__  ) / /__  
" /_____/\__,_/____/_/\___/  
"                           
set number                  " add line numbers
set relativenumber          " relative line numbering
set encoding=utf-8
set nocompatible            " Disable compatibility to old-time vi
set showmatch               " Show matching brackets.
set ignorecase              " Do case insensitive matching
set wildmode=full           " get bash-like tab completions
set clipboard+=unnamedplus
set noshowmode
set cursorline
filetype plugin indent on
" exrc allows loading local executing local rc files.
" secure disallows the use of :autocmd, shell and write commands in local .vimrc files.
set exrc
set secure
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set autoindent              " indent a new line the same amount as the line just typed
set smartindent             " smart indentation
set wrap 		    " Wrap lines
    
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Snippets
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" replace all is aliased to S.
nnoremap S :%s//g<Left><Left> 

" clears selections
map <silent> <leader><cr> :noh<cr>      

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Compilation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function CompileSettings ()
	write
	belowright split
	resize 10
	set nonumber
endfunction

autocmd filetype cpp nnoremap <F8> :call CompileSettings() <bar> term g++ -std=c++20 -Wall -Werror -Wextra -fsanitize=address,undefined % -o %:p:h/%:t:r.out && ./%:r.out<CR>
autocmd filetype c nnoremap <F8> :call CompileSettings() <bar> term gcc -std=c99 -Wall -Werror -Wextra % -o %:p:h/%:t:r.out && ./%:r.out<CR>
autocmd filetype python nnoremap <F8> :call CompileSettings() <bar> term python % <CR>
autocmd filetype sh nnoremap <F8> :call CompileSettings() <bar> term sh % <CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Themes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme monokai

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Debugging
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Custom
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function CPInit ()
     0r $CPDIR/home/artrivas/cp/template.cpp
endfunction



" 
" function CPTemplate ()
"     :Files $CPDIR/../kactl/content
" endfunction
" 
" function! CPYank ()
"     :! python3 $CPLIB/expander.py % -c --lib $CPLIB | python3 $ACLIB/expander.py /dev/stdin -c --lib $ACLIB | xclip -selection clipboard
" endfunction
" 
command! CPI call CPInit()
" command! CPT call CPTemplate()
" command! CPY call CPYank()

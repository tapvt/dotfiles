colors molokai
source ~/.vim/plugin/php-doc.vim
set pastetoggle=<F12>
syntax on

set iskeyword+=-

let javascript_fold=1

let g:ctrlp_open_new_file = 't'
let g:ctrlp_open_multiple_files = 'tr'
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': [],
  \ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
  \ }

set modeline
set number
set backspace=2
set ls=2
set scrolloff=7
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set nohidden
set hlsearch
set incsearch
set ignorecase
set smartcase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => <F*> bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F1> <ESC>
imap <F1> <ESC>
nmap <silent> <F2> :TlistToggle<CR>
nmap <silent> <F3> :NERDTreeToggle<CR>
nmap <silent> <F4> :tabprevious<CR>
nmap <silent> <F5> :tabnext<CR>
nmap <silent> <F6> :CheckSyntax<CR>
nmap <silent> <F7> :call PhpDocSingle()<CR>
nmap <silent> <F8> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nmap <silent> <F9> :call PHPClean()<CR>
nmap <silent> <F10> :call RemoveMultiSpace()<cr>
nnoremap <F11> :buffers<CR>:buffer<Space>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => colorcolumn setters
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> w0 :set colorcolumn=0 <CR>
nmap <silent> w70 :set colorcolumn=70 <CR>
nmap <silent> w80 :set colorcolumn=80 <CR>
nmap <silent> w120 :set colorcolumn=120 <CR>
nmap <silent> w240 :set colorcolumn=240 <CR>
nmap <silent> w. :let _c=col(".") set colorcolumn=_c<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FuzzyFinder Bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap ,f :FufFileWithCurrentBufferDir<CR>
nmap ,b :FufBuffer<CR>
nmap ,t :FufTaggedFile<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => TODO list tokens
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tlTokenList = ['TODO', 'todo', 'XXX', 'FIXME', 'WTF']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" show tabs and return whitespace
set list listchars=tab:▸\ ,eol:¬,trail:·

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Replace multiple space chars with one
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RemoveMultiSpace()
    :s/  \+/ /g
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Supify()
    :s/\(\^\)\(.\)/<sup>\2<\/sup>/g
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Clean common PHP code style issues
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PHPClean()
    :retab
    :set ff=unix
    :%s/){/) {/g
    :%s/for(/for (/g
    :%s/if(/if (/g
    :%s/else{/else {/g
    :%s/}else/} else/g
    :%s/foreach(/foreach (/g
    :%s/false/FALSE/g
    :%s/true/TRUE/g
    :%s/null/NULL/g
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Crosshairs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au TabLeave * set nocursorline nocursorcolumn
au TabEnter * set cursorline cursorcolumn
highlight CursorLine   ctermbg=darkgrey
highlight CursorColumn ctermbg=darkgrey
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Improved diff display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight DiffAdd term=reverse cterm=bold ctermbg=DarkGreen ctermfg=White
highlight DiffChange term=reverse cterm=bold ctermbg=DarkCyan ctermfg=White
highlight DiffText term=reverse cterm=bold ctermbg=DarkGray ctermfg=White
highlight DiffDelete term=reverse cterm=bold ctermbg=DarkRed ctermfg=White
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function to strip whitespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre *.php :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.twig :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.json :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.js :call <SID>StripTrailingWhitespaces()
autocmd BufWritePre *.hbs :call <SID>StripTrailingWhitespaces()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ \ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

hi StatusLine cterm=NONE ctermbg=black ctermfg=yellow

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/bweller/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cnoremap $h e ~/
cnoremap $d e ~/Desktop/
cnoremap $j e ./
cnoremap $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cnoremap $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

function! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

function! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endfunc

function! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => For better performance when editing large files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !exists("my_auto_commands_loaded")
  let my_auto_commands_loaded = 1
  let g:LargeFile = 1024 * 1024 * 10
  augroup LargeFile
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload undolevels=-1 | else | set eventignore-=FileType | endif
    augroup END
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => XML pretty print
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! PrettyXML :silent 1,$!xmllint --format --recover - 2>/dev/null
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


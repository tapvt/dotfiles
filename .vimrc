source ~/.vim/plugin/php-doc.vim
syntax on
colors molokai
au TabLeave * set nocursorline nocursorcolumn
au TabEnter * set cursorline cursorcolumn
set modeline
:hi CursorLine   ctermbg=darkgrey
:hi CursorColumn ctermbg=darkgrey
set number
set backspace=2
set ls=2
set scrolloff=7
set expandtab 
set tabstop=4 
set softtabstop=4
set shiftwidth=4
set mouse=a
set nohidden
set hlsearch
set incsearch
set ignorecase
set smartcase
nmap <F1> <ESC>
imap <F1> <ESC>
nmap <silent> <F2> :TlistToggle<CR>
nmap <silent> <F3> :NERDTreeToggle<CR>
nmap <silent> <F6> :CheckSyntax<CR>
nmap <silent> <F7> :call PhpDocSingle()<CR>
nmap <silent> <F8> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nmap <silent> <C-p> za
nmap <silent> <C-z> :u <CR>
nmap <silent> <C-b> :b
nmap <silent> <F9> :call PHPClean()<CR>
command! PrettyXML :silent 1,$!xmllint --format --recover - 2>/dev/null
nnoremap <silent> <F4> :tabprevious<CR>
nnoremap <silent> <F5> :tabnext<CR>
nnoremap <silent> <C-t> :tabnew<CR>

nmap ,f :FufFileWithCurrentBufferDir<CR>
nmap ,b :FufBuffer<CR>
nmap ,t :FufTaggedFile<CR>

let g:tlTokenList = ['TODO', 'todo', 'XXX', 'FIXME']

function! PHPClean()
    :retab
    :set ff=unix
    :%s/){/) {/g
    :%s/if(/if (/g
    :%s/else{/else {/g
    :%s/}else/} else/g
    :%s/foreach(/foreach (/g
    :%s/false/FALSE/g
    :%s/true/TRUE/g
    :%s/null/NULL/g
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function to select a range, and command
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! Rsel(Start, End)
    exe 'normal! ' . a:Start . 'G'
    exe 'norma! V'
    exe 'normal! ' . a:End . 'G'
endfunction
com!    -range -nargs=0 Rs call Rsel(<line1>, <line2>)
" :10,50 Rs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Function to strip whitespace
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre *.php :call <SID>StripTrailingWhitespaces()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ \ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

hi StatusLine cterm=NONE ctermbg=black ctermfg=yellow 

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
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
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
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

func! CurrentFileDir(cmd)
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


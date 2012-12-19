" Vim filetype plugin file
" Language:	json
" Maintainer:	Rogerz Zhang <rogerz.zhang@gmail.com>

if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

let b:undo_ftplugin = "setl ts< sw<"

setlocal autoindent
setlocal formatoptions=tcq2l
setlocal textwidth=120 shiftwidth=4
setlocal softtabstop=4 tabstop=4
setlocal expandtab
setlocal foldmethod=syntax

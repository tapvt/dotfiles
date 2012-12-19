au! BufRead,BufNewFile *.json set filetype=json
autocmd BufNewFile,BufRead *.json setf json
autocmd FileType json setl shiftwidth=2 | setl tabstop=2

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"The most important thing to do after initializations
execute pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
              \ | wincmd p | diffthis
endif

set wildmenu

set number "set line nubmers on

"Configur autoindentation, and general indentation rules
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

"Indentation prefferences for javascript
au Filetype javascript setlocal tabstop=2
au Filetype javascript setlocal shiftwidth=2
au Filetype javascript setlocal softtabstop=2

"Javascript syntax folding
au Filetype javascript syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend

"Configure Tab related shortcuts
map <F4> :tabe
map <F5> :tabp<CR>
map <F6> :tabn<CR>

"Configure Colemak related mappings
noremap h k
noremap j h
noremap k j

noremap gk gj
noremap gh gk

"Foldings
noremap zk zj
noremap zh zk
"Window Management
:nmap <silent> <C-j> :wincmd h<CR>
:nmap <silent> <C-k> :wincmd j<CR>
:nmap <silent> <C-h> :wincmd k<CR>
:nmap <silent> <C-l> :wincmd l<CR>

"Autocompletion
set ofu=syntaxcomplete#Complete
" " OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
""let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" " automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
"js
"let g:syntastic_javascript_checker = "jshint"
"let g:syntastic_javascript_closure_compiler_path = '/usr/share/java/closure-compiler/closure-compiler.jar'
"cpp
let g:syntastic_c_check_header = 1
let g:syntastic_cpp_check_header = 1
"python
let g:syntastic_python_checkers=['pylint']
"clang_complete
"let g:clang_complete_copen = 1

"invisible characters
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬,trail:•

"Colorscheme
nmap <leader>c :set cursorline!<CR>

"configure the path for ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

set laststatus=2 "to let the airline statusbar show before splitting
let g:airline_theme="molokai"

"Startify customizations
let g:startify_custom_header = [
            \ ' ____   ____  _                 _______  _    _    ',
            \ '|_  _| |_  _|(_)               |  ___  || |  | |   ',
            \ '  \ \   / /  __   _ .--..--.   |_/  / / | |__| |_  ',
            \ '   \ \ / /  [  | [ `.-. .-. |      / /  |____   _| ',
            \ '    \ " /    | |  | | | | | |     / /_      _| |_  ',
            \ '     \_/    [___][___||__||__]   /_/(_)    |_____| ',
            \ '',
            \ '',
            \ ]

"Configure Sexy Scroller
:let g:SexyScroller_EasingStyle = 2

"Configure Neocomplete (Copied from the plugin's readme file)
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"Configure neosnippet (copied from plugin's readme file)
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/snippets/snippets'

"Configure MultipleCursers
"Normal manual placings:
nnoremap <leader>mp :<c-u>call MultiCursorPlaceCursor()<cr>
"Normal removing of all cursers:
nnoremap <leader>mR :<c-u>call MultiCursorRemoveCursors()<cr>
"Activating normal manual placings:
nnoremap <leader>mg :<c-u>call MultiCursorManual()<cr>
"Select each line in Visual mode. Prepend with a number n to
"make it select each n lines:
xnoremap <leader>mp :<c-u>call MultiCursorVisual()<cr>
"Select cursers by search:
nnoremap <leader>mf :<c-u>call MultiCursorSearch('')<cr>
let g:multicursor_quit = "mq"

"Configure Signify
let g:signify_vcs_list = [ 'git', 'hg' ]

let g:signify_difftool = 'gnudiff'

let g:signify_mapping_next_hunk = '<leader>gk'
let g:signify_mapping_prev_hunk = '<leader>gh'

let g:signify_mapping_toggle_highlight = '<leader>gs'
let g:signify_mapping_toggle           = '<leader>gt'

let g:signify_skip_filetype = { 'vim': 1 }
"let g:signify_skip_filename = { '/home/user/.vimrc': 1 }

let g:signify_sign_overwrite = 1

let g:signify_update_on_bufenter = 0
let g:signify_update_on_focusgained = 0

let g:signify_line_highlight = 0

let g:signify_sign_add               = '+'
let g:signify_sign_change            = '!'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'

let g:signify_cursorhold_normal = 1
let g:signify_cursorhold_insert = 1

"Configure Tagbar for javascript
let g:tagbar_type_javascript = {
    \ 'ctagsbin' : '/usr/bin/jsctags'
\ }

"Configure clever-f
let g:clever_f_across_no_line=1

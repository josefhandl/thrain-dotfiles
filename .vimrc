" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

set number
highlight LineNr ctermfg=DarkGrey ctermbg=None

set colorcolumn=80,120
highlight ColorColumn ctermbg=DarkGrey

" Declare the list of plugins.
"Plug 'tpope/vim-sensible'
"Plug 'junegunn/iseoul256.vim'
Plug 'vim-airline/vim-airline'
"Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"Plug 'jmcantrell/vim-virtualenv'

let g:airline_powerline_fonts=1
let g:airline_statusline_ontop=0

"if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
"endif

let g:airline_left_sep = "\uE0BC"
let g:airline_right_sep = "\uE0BA"

"function! AirlineInit()
"let g:airline_section_a = airline#section#create(['mode','branch'])
"let g:airline_section_b = airline#section#create('%{virtualenv#statusline()}')
"let g:airline_section_c = '%{hostname()}'
"endfunction
"autocmd VimEnter * call AirlineInit()

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

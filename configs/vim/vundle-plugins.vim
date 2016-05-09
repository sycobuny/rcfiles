""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle-plugins.vim - Specifying/configuring various Vundle plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin to add a fancy status line to Vim
" NOTE: For this to look decent on Mac OS X, you need to download a Powerline
" patched font and enable it, or build your own. I use "Menlo" patched
" from https://gist.github.com/1595572.
" I use the old version because the new version requires Python and
" compilation, which... no.
Plugin 'Lokaltog/vim-powerline'
set laststatus=2 " turn on statusbar

" determine whether we're running under tmux, and if so: make sure we aren't
" running 2.2. if we are, we can't use special unicode symbols in powerline
" anymore cause tmux erased its internal UTF tables (so we have to fall
" back to more-standard unicode symbols):
" https://github.com/tmux/tmux/commit/26945d7956bf1f160fba72677082e1a9c6968e0c
let s:tmux = $TMUX
if s:tmux == ''
    let s:usefancy = 1
else
    let s:tmux_version = system('tmux -V | cut -d\  -f2')

    if match(s:tmux_version, '2.2') < 0
        let s:usefancy = 1
    else
        let s:usefancy = 0
    endif
endif
if s:usefancy
    let g:Powerline_symbols = 'fancy'   " use fancy utf-8 symols
else
    let g:Powerline_symbols = 'unicode' " use less-fancy unicode replacements
endif

" Plugin to do 'fuzzy search' for files
Plugin 'kien/ctrlp.vim'

" Plugin to auto-align elements in a line
Plugin 'godlygeek/tabular'

" Plugin to split and join code lines based on contextual information
Plugin 'AndrewRadev/splitjoin.vim'

" Plugin to add mappings for quickly wrapping w/alanced brackets/quotes/etc.
Plugin 'tpope/vim-surround'

" Plugin to add syntax/indent/filetypes for git-related files/processes
Plugin 'tpope/vim-git'

" Plugin to add IDE-like git compatibility features/commands to Vim
Plugin 'tpope/vim-fugitive'

" Plugin to map file paths to automatic commands/substitutions/etc.
Plugin 'tpope/vim-projectionist'

" Plugin to run build/server commands asynchronously in alternate windows
Plugin 'tpope/vim-dispatch'

" Plugin to add Procfile/.env file support and translation
Plugin 'tpope/vim-dotenv'

" Plugin to add better syntax styling for Markdown, including GFM
Plugin 'tpope/vim-markdown'
let g:markdown_fenced_languages = [
    \       'apacheconf=apache', 'aconf=apache', 'html', 'css', 'javascript',
    \       'perl', 'ruby', 'php', 'diff'
    \   ]

" Plugin to greatly improve Vim file browsing
Plugin 'scrooloose/nerdtree'

" Plugin to do linting and hinting of code while editing
Plugin 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_mode_map = {
    \       'mode':              'active',
    \       'passive_filetypes': ['puppet']
    \   }

" Plugin to graph the full undo tree history
Plugin 'mbbill/undotree'

" Plugin to add syntax files for the Puppet language
Plugin 'puppetlabs/puppet-syntax-vim'

" Plugin to add highlighted 'indentation guides'
" NOTE: This plugin uses matchadd() all over the place and causes tons of
" errors if that doesn't exist, so we'll check for it before trying to turn
" any of it on, since vim older than 7.2 isn't guaranteed to have it.
if exists('*matchadd')
    Plugin 'nathanaelkane/vim-indent-guides'

    " prevent errors from cropping up from a missing bgcolor spec
    highlight Normal ctermbg=white

    let g:indent_guides_start_level = 2 " don't indent-guide the left gutter
    let g:indent_guides_guide_size  = 1 " use one-char-wide highlight cols
    let g:indent_guides_auto_colors = 0 " we'll set the guide colors

    " use colors that work with our colorscheme (Badwolf)
    autocmd VimEnter,Colorscheme * highlight IndentGuidesOdd  ctermbg=248
    autocmd VimEnter,Colorscheme * highlight IndentGuidesEven ctermbg=252

    " make sure indent guides are enabled by default
    autocmd VimEnter * :IndentGuidesEnable
endif

" Plugin to improve ease-of-use for custom marks
Plugin 'kshenoy/vim-signature'

" Plugin to allow syntax highlighting chunks of files with different languages
Plugin 'SyntaxRange'
autocmd FileType vim call SyntaxRange#Include('perl <<', '.', 'perl')
autocmd FileType sql call SyntaxRange#Include(
    \       '  AS \$PERL\$', '  \$PERL\$;', 'perl'
    \   )
autocmd FileType sql call SyntaxRange#Include(
    \       'DO \$PERL\$', '\$PERL\$ LANGUAGE PLPERL;', 'perl'
    \   )

" Plugin to add mappings for easy system clipboard copy/pasting
Plugin 'christoomey/vim-system-copy'

" Plugin to allow easy custom text objects (dependency for the plugin below)
Plugin 'kana/vim-textobj-user'

" Plugin to add a couple text objects for dealing with the entire buffer
Plugin 'kana/vim-textobj-entire'

" Plugin to mimic emacs slime - copy text as commands to another window
Plugin 'jpalardy/vim-slime'
let g:slime_target = 'tmux' " tmux rocks \m/

" Plugin to highlight excess whitespace
Plugin 'jpalardy/spacehi.vim'

" Plugin to auto-write closing delimiters when opening ones are typed
Plugin 'Raimondi/delimitMate'

" Plugin to provide tab-expansion of commond constructs
Plugin 'msanders/snipmate.vim'

" Plugin to improve syntax files for PHP
Plugin 'vim-scripts/php.vim--Garvin'

" Plugin to imrpove syntax files for Perl
Plugin 'vim-scripts/perl-mauke.vim'
let perl_include_pod = 1
let perl_fold        = 1

" Plugin to set up our colorscheme: Paper Color
Plugin 'NLKNguyen/papercolor-theme'
silent! colorscheme PaperColor

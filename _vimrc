" =============================================================================
"        << �жϲ���ϵͳ�� Windows ���� Linux ���ж����ն˻��� Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < �жϲ���ϵͳ�Ƿ��� Windows ���� Linux >
" -----------------------------------------------------------------------------
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif

" -----------------------------------------------------------------------------
"  < �ж����ն˻��� Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif


" =============================================================================
"                          << ����Ϊ���Ĭ������ >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Windows Gvim Ĭ������> ����һ���޸�
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()

    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim Ĭ������> ����һ���޸�
" -----------------------------------------------------------------------------
if !g:iswindows
    set hlsearch        "��������
    set incsearch       "������Ҫ����������ʱ��ʵʱƥ��

    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim

        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif

        set mouse=a                    " ���κ�ģʽ���������
        set t_Co=256                   " ���ն�����256ɫ
        set backspace=2                " �����˸������

        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif


" =============================================================================
"                          << ����Ϊ�û��Զ������� >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Vundle ������������� >
" -----------------------------------------------------------------------------
" ���ڸ�����Ĺ���vim����������÷��ο� :h vundle ����
" ��װ����Ϊ���ն�������������
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

set nocompatible                                      "���� Vi ����ģʽ
filetype off                                          "�����ļ��������

if !g:iswindows
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

" ʹ��Vundle������Vundle���������Ҫ�С�
Bundle 'gmarik/vundle'

" ����ΪҪ��װ����µĲ������ͬ�ֿⶼ�У�������д�淶��ο�������

"Bundle ''
Bundle 'jaytang0923/a.vim'
Bundle 'jaytang0923/c.vim'
Bundle 'jaytang0923/taglist.vim'
Bundle 'neocomplcache'
Bundle 'echofunc.vim'
Bundle 'The-NERD-tree'			
"Bundle 'minibufexpl.vim'
"Bundle 'wesleyche/SrcExpl'
"Bundle 'wesleyche/Trinity'
Bundle 'ervandew/supertab'
"Bundle 'snipMate'
"Bundle 'AutoTag'
Bundle 'L9'
Bundle 'FuzzyFinder'								
"Bundle 'project.tar.gz'				"��˵����NERD�Ϳ�����
"Bundle 'molokai'
Bundle 'std_c.zip'
Bundle 'scrooloose/syntastic'
Bundle 'drmingdrmer/xptemplate'
Bundle 'TabBar'
Bundle 'OmniCppComplete'
Bundle 'jaytang0923/project.vim'
Bundle 'vimwiki'

" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
" ע��ʹ��utf-8��ʽ����������Դ�롢�ļ�·�����������ģ����򱨴�
set encoding=utf-8                                    "����gvim�ڲ�����
set fileencoding=utf-8                                "���õ�ǰ�ļ�����
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "����֧�ִ򿪵��ļ��ı���

" �ļ���ʽ��Ĭ�� ffs=dos,unix
set fileformat=unix                                   "�������ļ���<EOL>��ʽ
set fileformats=unix,dos,mac                          "�����ļ���<EOL>��ʽ����

if (g:iswindows && g:isGUI)
    "����˵�����
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "���consle�������
    language messages zh_CN.utf-8
endif


" -----------------------------------------------------------------------------
"  < ��д�ļ�ʱ������ >
" -----------------------------------------------------------------------------
filetype on                                           "�����ļ��������
filetype plugin on                                    "��Բ�ͬ���ļ����ͼ��ض�Ӧ�Ĳ��
filetype plugin indent on                             "��������,ͬʱҲ��Vundle�ı��벽
set smartindent                                       "�������ܶ��뷽ʽ
set expandtab                                         "��Tab��ת��Ϊ�ո�
set tabstop=4                                         "����Tab���Ŀ��
set shiftwidth=4                                      "����ʱ�Զ�����4���ո�
set smarttab                                          "ָ����һ��backspace��ɾ��shiftwidth��ȵĿո�
"set foldenable                                        "�����۵�
"set foldmethod=indent                                 "indent �۵���ʽ
" set foldmethod=marker                                "marker �۵���ʽ


" �ÿո���������۵�
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" ���ļ����ⲿ���޸ģ��Զ����¸��ļ�
set autoread

" ����ģʽ������ cS �����β�ո�
nmap cS :%s/\s\+$//g<cr>:noh<cr>

" ����ģʽ������ cM �����β ^M ����
nmap cM :%s/\r$//g<cr>:noh<cr>

set ignorecase                                        "����ģʽ����Դ�Сд
set smartcase                                         "�������ģʽ������д�ַ�����ʹ�� 'ignorecase' ѡ�ֻ������������ģʽ���Ҵ� 'ignorecase' ѡ��ʱ�Ż�ʹ��
" set noincsearch                                       "������Ҫ����������ʱ��ȡ��ʵʱƥ��

" Ctrl + K ����ģʽ�¹�������ƶ�
imap <c-k> <Up>

" Ctrl + J ����ģʽ�¹�������ƶ�
imap <c-j> <Down>

" Ctrl + H ����ģʽ�¹�������ƶ�
imap <c-h> <Left>

" Ctrl + L ����ģʽ�¹�������ƶ�
imap <c-l> <Right>

" ÿ�г���80�����ַ����»��߱�ʾ
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
set number                                            "��ʾ�к�
set laststatus=2                                      "����״̬����Ϣ
set cmdheight=2                                       "���������еĸ߶�Ϊ2��Ĭ��Ϊ1
set cursorline                                        "ͻ����ʾ��ǰ��
" set guifont=YaHei_Consolas_Hybrid:h10                 "��������:�ֺţ��������ƿո����»��ߴ��棩
set nowrap                                            "���ò��Զ�����
set shortmess=atI                                     "ȥ����ӭ����
" au GUIEnter * simalt ~x                              "��������ʱ�Զ����
winpos 100 10                                         "ָ�����ڳ��ֵ�λ�ã�����ԭ������Ļ���Ͻ�
set lines=38 columns=120                              "ָ�����ڴ�С��linesΪ�߶ȣ�columnsΪ���

" ���ô�����ɫ����
if g:isGUI
    colorscheme desert               "Gvim��ɫ����
else
    colorscheme desert							"Tomorrow-Night-Eighties  "�ն���ɫ����
endif

" ���Ի�״���������ṩ���ַ�ʽ��Ҫʹ������һ��ȥ��ע�ͼ��ɣ���ʹ�÷�֮��
" let &statusline=' %t %{&mod?(&ro?"*":"+"):(&ro?"=":" ")} %1*|%* %{&ft==""?"any":&ft} %1*|%* %{&ff} %1*|%* %{(&fenc=="")?&enc:&fenc}%{(&bomb?",BOM":"")} %1*|%* %=%1*|%* 0x%B %1*|%* (%l,%c%V) %1*|%* %L %1*|%* %P'
" set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=%l%3*/%L(%p%%)%*,%c%V]\ [%b:0x%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}%{&eol?'':',NOEOL'}]

" ��ʾ/���ز˵������������������������� Ctrl + F11 �л�
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif



" -----------------------------------------------------------------------------
"  < ���롢���ӡ��������� >
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
"  < �������� >
" -----------------------------------------------------------------------------
set writebackup                             "�����ļ�ǰ�������ݣ�����ɹ���ɾ���ñ���
set nobackup                                "�����ޱ����ļ�
" set noswapfile                              "��������ʱ�ļ�
set vb t_vb=                                "�ر���ʾ��

" =============================================================================
"                          << ����Ϊ���ò������ >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < a.vim ������� >
" -----------------------------------------------------------------------------
" �����л�C/C++ͷ�ļ�
" :A     ---�л�ͷ�ļ�����ռ��������
" :AV    ---�л�ͷ�ļ�����ֱ�ָ��
" :AS    ---�л�ͷ�ļ���ˮƽ�ָ��
"Ϊ�˷�ֹ��c.vim��is��ͻ,�޸Ĳ���е�is,����֮

" -----------------------------------------------------------------------------
"  < c.vim ������� >
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
"  < TagList ������� >
" -----------------------------------------------------------------------------
" ��Ч�����Դ��, �书�ܾ���vc�е�workpace
" �������г��˵�ǰ�ļ��е����к�,ȫ�ֱ���, ��������

" ����ģʽ������ tl ���ò��������д� Tagbar �������Ƚ���ر�
nmap tl :TagbarClose<cr>:Tlist<cr>

let Tlist_Show_One_File=1                   "ֻ��ʾ��ǰ�ļ���tags
" let Tlist_Enable_Fold_Column=0              "ʹtaglist�������ʾ��ߵ��۵���
let Tlist_Exit_OnlyWindow=1                 "���Taglist���������һ���������˳�Vim
let Tlist_File_Fold_Auto_Close=1            "�Զ��۵�
let Tlist_WinWidth=30                       "���ô��ڿ��
let Tlist_Use_Right_Window=0                "����ര������ʾ
let Tlist_Auto_Open=1						"�Զ���tlist
let Tlist_Inc_Winwidth=0					"���ı�vim�����С


" -----------------------------------------------------------------------------
"  < neocomplcache ������� >
" -----------------------------------------------------------------------------
" �ؼ��ֲ�ȫ���ļ�·����ȫ��tag��ȫ�ȵȣ����֣��ǳ����ã��ٶȳ��졣
" Disable AutoComplPop.  �ر�AutoComplPop��������ͻ
let g:acp_enableAtStartup = 0 
"vim ����ʱ���ò��
let g:neocomplcache_enable_at_startup = 1     
" let g:neocomplcache_disable_auto_complete = 1 "���Զ�������ȫ�б�
" �ڵ�����ȫ�б���� <c-p> �� <c-n> ��������ѡ��Ч���ȽϺ�
"���ÿ���ƥ�䣺
let g:neocomplcache_enable_quick_match = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_min_syntax_length = 3																		"�ӵ�������ĸ��ʼƥ��
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" " -----------------------------------------------------------------------------
" "  < WinManager ������� >
" " -----------------------------------------------------------------------------
" " �����������, ����˵���ϸ�������

" " ����ģʽ������ F3 ���ò��
"nmap <F3> :WMToggle<cr>

" " �����������Ϊ�������, ��'FileExplorer|TagList'
"let g:winManagerWindowLayout='FileExplorer'

" let g:persistentBehaviour=0                 "ֻʣһ������ʱ, �˳�vim
" let g:winManagerWidth=30                    "���ô��ڿ��

" -----------------------------------------------------------------------------
"  < nerdtree ������� >
" -----------------------------------------------------------------------------
" ��Ŀ¼��ṹ���ļ�������
let NERDTreeWinPos=1							"NERD tree ��ʾ���ұ�
autocmd VimEnter * NERDTree				"�Զ���NERD tree


" " -----------------------------------------------------------------------------
" "  < MiniBufExplorer ������� >
" " -----------------------------------------------------------------------------
" " ��������Ͳ���Buffer
" " ��Ҫ����ͬʱ�򿪶���ļ��������л�

" " let g:miniBufExplMapWindowNavArrows = 1     "��Ctrl�ӷ�����л����������ҵĴ�����ȥ
" let g:miniBufExplMapWindowNavVim = 1        "��<C-k,j,h,l>�л����������ҵĴ�����ȥ
" let g:miniBufExplMapCTabSwitchBufs = 1      "������ǿ����������ֻ����Windows�в����ã�
" "                                            <C-Tab> ��ǰѭ���л���ÿ��buffer��,���ڵ�ǰ���ڴ�
" "                                            <C-S-Tab> ���ѭ���л���ÿ��buffer��,���ڵ�ǰ���ڴ�

" �ڲ�ʹ�� MiniBufExplorer ���ʱҲ����<C-k,j,h,l>�л����������ҵĴ�����ȥ
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" -----------------------------------------------------------------------------
"  < snipMate ������� >
" -----------------------------------------------------------------------------
" ���ڸ��ִ��벹ȫ�����ֲ�ȫ��һ�ֶԴ����еĴ����������д��ȫ����ϸ�÷����Բ�
" ��ʹ��˵��������̵̳ȡ�������ʱ��Ҳ���� supertab ����ڲ�ȫʱ������ͻ�������
" ����ʲô�����������ϣ����Ҫ����ѽ

" -----------------------------------------------------------------------------
"  < SrcExpl ������� >
" -----------------------------------------------------------------------------
" ��ǿԴ����������书�ܾ���Windows�е�"Source Insight"
" :SrcExpl                                   "���������
" :SrcExplClose                              "�ر��������
" :SrcExplToggle                             "��/���������

" // The switch of the Source Explorer                                         " 
"nmap <F10> :SrcExplToggle<CR> 
" // Set the height of Source Explorer window                                  " 
"let g:SrcExpl_winHeight = 8 
" // Set 100 ms for refreshing the Source Explorer                             " 
"let g:SrcExpl_refreshTime = 100 
" // In order to Avoid conflicts, the Source Explorer should know what plugins " 
" // are using buffers. And you need add their buffer names into below list    " 
" // according to the command ":buffers!"                                      " 
"let g:SrcExpl_pluginList = [ 
"         \ "__Tag_List__", 
"         \ "_NERD_tree_", 
"         \ "Source_Explorer" 
"     \ ] 

"ctags ������չ
"let g:SrcExpl_updateTagsCmd = "ctags -R --fields=+lS"			
"����tags							
"let g:SrcExpl_updateTagsKey = "<F11>"	
" // Do not let the Source Explorer update the tags file when opening          " 
"let g:SrcExpl_isUpdateTags = 0 
"autocmd VimEnter *	SrcExplToggle							"�Զ���/���������


" " -----------------------------------------------------------------------------
" "  < supertab ������� >
" " -----------------------------------------------------------------------------
" " ����Ҫ������� omnicppcomplete ������ڰ� Tab ��ʱ�Զ���ȫЧ�����ø���
let g:supertabdefaultcompletiontype = "<c-x><c-u>"
" 0 - ����¼�ϴεĲ�ȫ��ʽ
" 1 - ��ס�ϴεĲ�ȫ��ʽ,ֱ���������Ĳ�ȫ����ı���
" 2 - ��ס�ϴεĲ�ȫ��ʽ,ֱ����ESC�˳�����ģʽΪֹ
let g:SuperTabRetainCompletionType=2  

" -----------------------------------------------------------------------------
"  < std_c ������� >
" -----------------------------------------------------------------------------
" ������ǿC�﷨����

" ���� // ע�ӷ��
let c_cpp_comments = 0

" -----------------------------------------------------------------------------
"  < Trinity ������� >
" -----------------------------------------------------------------------------
" Open and close all the three plugins on the same time 
"nmap <F12>   :TrinityToggleAll<CR> 
" Open and close the srcexpl.vim separately 
"nmap <F9>   :TrinityToggleSourceExplorer<CR> 
"autocmd VimEnter * TrinityToggleAll				"�Զ�����

" -----------------------------------------------------------------------------
"  < Syntastic ������� >
" -----------------------------------------------------------------------------
" ���ڱ����ļ��ǲ���﷨

" -----------------------------------------------------------------------------
"  < TabBar ������� >
" -----------------------------------------------------------------------------
"Ctrl+Tab��ģ��tab����л���
"����һ��tab���ڸ߶ȵ����ֵ��
let g:Tb_MaxSize = 3

" -----------------------------------------------------------------------------
"  < Omnicppcomplete ������� >
"��Ҫ�ǶԽṹ�岹ȫ��֧��,������Ϊ��ȥ�����˵�Ԥ����
" -----------------------------------------------------------------------------
" Omnicppcomplete settings ( Close the preview window automatically )
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menu									"�ر�Ԥ����


" -----------------------------------------------------------------------------
"  < FuzzyFinder  ������� >
" -----------------------------------------------------------------------------
nnoremap <leader>ff :FufFile<CR> 
"nnorempa <leader>fb :FufBuffer<CR> 


" =============================================================================
"                          << ����Ϊ���ù������� >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < cscope �������� >
" -----------------------------------------------------------------------------
" ��Cscope�Լ��Ļ�˵ - "����԰��������ǳ���Ƶ��ctags"
if has("cscope")
    "�趨����ʹ�� quickfix �������鿴 cscope ���
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    "ʹ֧���� Ctrl+]  �� Ctrl+t ��ݼ��ڴ������ת
    set cscopetag
    "������뷴������˳������Ϊ1
    set csto=0
    "�ڵ�ǰĿ¼������κ����ݿ�
    if filereadable("cscope.out")
        cs add cscope.out
    "����������ݿ⻷������ָ����
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set cscopeverbose
    "��ݼ�����
    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

"ÿ�α����ļ�ʱ���Զ�����tags
"autocmd GUIEnter * winsize 167 41
"autocmd BufWritePost *.cpp,*.c,*.h :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q
nmap <F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q

" ����ʱ���


"Ԥ��
set updatetime=50
"setup for ctags auto-cursor-preview
au! CursorHold *.[ch] nested call PreviewWord()
func PreviewWord()
  if &previewwindow                     " don't do this in the preview window
    return
  endif
  let w = expand("<cword>")             " get the word under cursor
  if w =~ '\a'                          " if the word contains a letter 
    " Delete any existing highlight before showing another tag
    silent! wincmd P                    " jump to preview window
    if &previewwindow                   " if we really get there...
      match none                        " delete existing highlight
      wincmd p                          " back to old window
    endif
    " Try displaying a matching tag for the word under the cursor
    try
      exe "belowright ptag " . w
    catch
      return
    endtry
    silent! wincmd P                    " jump to preview window
    if &previewwindow                   " if we really get there...
      if has("folding")
        silent! .foldopen               " don't want a closed fold
      endif
      call search("$", "b")             " to end of previous line
      let w = substitute(w, '\\', '\\\\', "")
      call search('\<\V' . w . '\>')    " position cursor on match
      " Add a match highlight to the word at this position
      hi previewWord term=bold ctermbg=green guibg=green
      exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
      wincmd p                          " back to old window
    endif
  endif
endfun

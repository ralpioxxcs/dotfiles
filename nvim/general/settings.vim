set iskeyword+=-
set formatoptions-=cro

syntax on
set hidden                  " 버퍼를 수정한 직후 버퍼를 감춰지도록 함
set wrap                    " 자동 줄 바꿈
set encoding=UTF-8          " UTF-8 인코딩
set t_Co=256                " 256 칼라 지원
set number                  " 라인 수 표시
set ruler                   " 커서 표시
set cursorline              " 현재 커서 하이라이팅
set pumheight=10            " 팝업 메뉴 크기 조정
set showcmd                 " 명령어를 상태라인에 보여준다
set mouse=a                 " 마우스 사용 가능
set tabstop=2               ""
set shiftwidth=2            ""
set smarttab                ""
set smartindent             " 새로운 라인 시작 시, auto indentation 수행
set autoindent              " 자동 들여쓰기
set expandtab               " tab을 space로 확장
set showmatch               " 매칭되는 괄호 표시
set background=light
set showtabline=2
set noshowmode
set nobackup                " 백업파일을 생성하지 않는다
set signcolumn=yes
set updatetime=300
set timeoutlen=100
set clipboard=unnamedplus   " 클립보드 복사&붙여넣기 허용
set incsearch               " 점진적으로 찾기
set hlsearch                " 검색어 하이라이팅
set nowrapscan              " 찾기 파일 맨 끝 도달시, 계속하여 찾지 않음
set guifont=Hack\ Nerd\ Font " 폰트 설정
set ignorecase              " 검색시 대소문자 구별 X

" 파일 열기 마지막 부분 저장
if has("autocmd")
" When editing a file, always jump to the last cursor position
 autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \ exe "normal g'\"" |
  \ endif
endif

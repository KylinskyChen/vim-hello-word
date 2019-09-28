" ========================================================================
" FileName: autoload/helloword/util.vim
" Description:
" Author: voldikss
" GitHub: https://github.com/voldikss
" ========================================================================

function! helloword#util#showMessage(message, ...)
  if a:0 == 0
    let msgType = 'more'
  else
    let msgType = a:1
  endif

  if msgType == 'more'
    echohl MoreMsg
  elseif msgType == 'warning'
    echohl WarningMsg
  elseif msgType == 'error'
    echohl ErrorMsg
  endif

  if type(a:message) != 1
    let message = join(a:message, "\n")
  else
    let message = a:message
  endif

  echo message
  echohl None
endfunction

function! helloword#util#prompt(prompt, candidates)
  echohl Title
  echo "\n==> " . a:prompt
  echohl None

  let i = 1
  let input_list = []
  echohl MoreMsg
  for cand in a:candidates
    echo '    ' . i . '. ' . cand
    let i += 1
  endfor
  return input("请输入：")
  echohl None
endfunction

function! helloword#util#random(range) abort
  if has("reltime")
    let l:timerstr=reltimestr(reltime())
    let l:number=split(l:timerstr, '\.')[1]+0
  elseif has("win32") && &shell =~ 'cmd'
    let l:number=system("echo %random%")+0
  else
    let l:number=expand("$RANDOM")+0
  endif
  return l:number % a:range
endfunction

function! helloword#util#shuffle(list) abort
  let pos = len(a:list)
  while 1 < pos
    let n = helloword#util#random(pos)
    let pos -= 1
    if n != pos
      let temp = a:list[n]
      let a:list[n] = a:list[pos]
      let a:list[pos] = temp
    endif
  endwhile
  return a:list
endfunction

function! helloword#util#safeTrim(text)
  return substitute(a:text, "^\\s*\\(.\\{-}\\)\\(\\n\\|\\s\\)*$", '\1', '')
endfunction

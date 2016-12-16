let g:ccmd = "silent !/usr/bin/osascript << EOF\n"
let g:osacmd = "tell application \"iTerm2\"\n
  \  tell first session of current tab of current window\n
  \    write text command\n
  \  end tell\n
  \end tell\n
  \EOF\n"

function! s:ITermTestRunnerLine()
  let osavar = "set command to \"rspec ".expand("%").":".line(".")."\"\n"
  silent exec g:ccmd.osavar.g:osacmd
  silent exec 'redraw!'
endfunction

function! s:ITermTestRunnerFile()
  let osavar = "set command to \"rspec ".expand("%")."\"\n"
  silent exec g:ccmd.osavar.g:osacmd
  silent exec 'redraw!'
endfunction

command! -nargs=* TTRF call s:ITermTestRunnerFile()
command! -nargs=* TTRL call s:ITermTestRunnerLine()

nnoremap <leader>t :call <SID>ITermTestRunnerLine()<cr>
nnoremap <leader>T :call <SID>ITermTestRunnerFile()<cr>

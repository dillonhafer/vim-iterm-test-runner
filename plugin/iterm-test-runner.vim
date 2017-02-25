let g:osaclear = "!/usr/bin/osascript -e 'tell application \"iTerm2\" to tell first session of current tab of current window to write text \"clear\"'"
let g:ccmd = "!/usr/bin/osascript "
let g:osacmd = " -e 'tell application \"iTerm2\" to tell first session of current tab of current window to write text command'"

function! s:ITermTestRunnerLine()
  silent exec g:osaclear
  let osavar = "-e 'set command to \"rspec ".expand("%").':'.line(".")."\"'"
  silent exec g:ccmd.osavar.g:osacmd
  silent exec 'redraw!'
endfunction

function! s:ITermTestRunnerFile()
  silent exec g:osaclear
  let osavar = "-e 'set command to \"rspec ".expand("%")."\"'"
  silent exec g:ccmd.osavar.g:osacmd
  silent exec 'redraw!'
endfunction

command! -nargs=* RspecTestFile call s:ITermTestRunnerFile()
command! -nargs=* RspecTestLine call s:ITermTestRunnerLine()

nnoremap <leader>t :call <SID>ITermTestRunnerLine()<cr>
nnoremap <leader>T :call <SID>ITermTestRunnerFile()<cr>

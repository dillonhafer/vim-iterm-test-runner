function! s:ITermTestRunnerLine()
  let currentLine = line(".")
  let currentFile = expand("%")
  silent exec "silent !/usr/local/bin/test-runner.sh ".currentFile." ".currentLine
  silent exec 'redraw!'
endfunction

function! s:ITermTestRunnerFile()
  let currentFile = expand("%")
  silent exec "silent !/usr/local/bin/test-runner.sh ".currentFile
  silent exec 'redraw!'
endfunction

command! -nargs=* TTRF call s:ITermTestRunnerFile()
command! -nargs=* TTRL call s:ITermTestRunnerLine()

nmap <leader>t :call <SID>ITermTestRunnerLine()<cr>
nmap <leader>T :call <SID>ITermTestRunnerFile()<cr>

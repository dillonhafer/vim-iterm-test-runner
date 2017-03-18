function! s:ITermCommand(type, path, line)
  let runner = "rspec "
  if &ft == "cucumber"
    let runner = "cucumber "
  endif

  let osavar = "-e 'set command to \"".l:runner.a:path."\"'"
  if a:type == "line"
    let osavar = "-e 'set command to \"".l:runner.a:path.':'.a:line."\"'"
  endif

  let osaclear = "osascript -e 'tell application \"iTerm2\" to tell first session of current tab of current window to write text \"clear\"' </dev/null >/dev/null"
  let ccmd = "osascript "
  let osacmd = " -e 'tell application \"iTerm2\" to tell first session of current tab of current window to write text command' </dev/null >/dev/null"

  let job1 = job_start(["sh", "-c", l:osaclear])
  sleep 100m
  let job2 = job_start(["sh", "-c", l:ccmd.l:osavar.l:osacmd], {'exit_cb': 'ExitTestsHandler'})
endfunction

function! ExitTestsHandler(job, status)
  echom ""
endfunction

function! s:ITermTestRunner(type)
  call s:EchoProgress("testing...")
  let path = expand("%p")
  let current_line = line(".")
  call s:ITermCommand(a:type, path, current_line)
endfunction

function! s:EchoProgress(msg)
  redraw | echohl Identifier | echom "vim-termbux: " . a:msg | echohl None
endfunction

command! -nargs=* RspecTestFile call s:ITermTestRunner("file")
command! -nargs=* RspecTestLine call s:ITermTestRunner("line")

nnoremap <leader>t :call <SID>ITermTestRunner("line")<cr>
nnoremap <leader>T :call <SID>ITermTestRunner("file")<cr>

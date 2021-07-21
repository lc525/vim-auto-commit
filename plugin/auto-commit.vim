function! AutoCommit()
  let git_dir = system("git rev-parse --show-toplevel | tr -d '\\n'")
  if v:shell_error
    return
  endif
  
  let last_commit = system("git log --oneline --format=%B | head -n 1 | tr -d '\\n'")
  let current_log = system("tac " . git_dir . "/dev.log | grep -m 1 '.' | grep '^-' | sed 's/^-\\s*/WIP: /' | tr -d '\\n'")
  call system('git add -A')
  if last_commit ==# current_log
    call system('git commit --amend -a --no-edit')
  else
    call system('git commit -a -m ' . shellescape(current_log, 1))
  endif
endfun

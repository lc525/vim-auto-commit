function! AutoCommit()
  let git_dir = system("git rev-parse --show-toplevel | tr -d '\\n'")
  if v:shell_error
    return
  endif
  
  let last_commit = system("git log --oneline --format=%B | head -n 1 | tr -d '\\n'")
  let current_log = system("tail -n1 " . git_dir . "/dev.log | grep '^-' | sed 's/^-\\s*/WIP: /' | tr -d '\\n'")
  if last_commit ==# current_log
    call system('git commit --amend -A --no-edit')
  else
    call system('git commit -A -m ' . shellescape(current_log, 1))
  endif
endfun

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim


command! -nargs=+ -complete=shellcmd AsyncuteRun call asyncute#run(<q-args>)

command! AsyncuteStop call asyncute#stop()


let &cpo = s:save_cpo
unlet s:save_cpo

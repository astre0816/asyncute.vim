scriptencoding utf-8

if !exists('g:loaded_asyncute')
	finish
endif
let g:loaded_asyncute = 1

let s:save_cpo = &cpo
set cpo&vim


function! s:handler(ch, msg) abort
endfunction

function! s:finisher(job, exit_status) abort
	echo "finish ".a:exit_status." ".join(s:commands, ',')
	unlet s:job
endfunction

function! asyncute#run(cmd) abort
	let s:commands = ['sh', '-c', a:cmd]

	if exists('s;job')
		echo "job is already running"
		return
	endif

	let s:bnr = bufnr("%")
	let s:job = job_start(s:commands, {
				\	'callback' : function('s:handler'),
				\	'exit_cb' : function('s:finisher'),
				\	'out_io' : "buffer",
				\	'out_buf' : s:bnr,
				\	'err_io' : "buffer",
				\	'err_buf' : s:bnr
				\})

	echo "run ".join(s:commands, ',')
endfunction

function! asyncute#stop() abort
	if !exists('s:job')
		echo "job is not running"
		return
	endif

	call job_stop(s:job)
	echo "stop ".join(s:commands, ',')
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

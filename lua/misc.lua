vim.cmd [[
" https://gist.github.com/romainl/eae0a260ab9c135390c30cd370c20cd7
function! Redir(cmd, rng, start, end)
for win in range(1, winnr('$'))
	if getwinvar(win, 'scratch')
		execute win . 'windo close'
		endif
		endfor
		if a:cmd =~ '^!'
			let cmd = a:cmd =~' %'
			\ ? matchstr(substitute(a:cmd, ' %', ' ' . shellescape(escape(expand('%:p'), '\')), ''), '^!\zs.*')
			\ : matchstr(a:cmd, '^!\zs.*')
			if a:rng == 0
				let output = systemlist(cmd)
			else
				let joined_lines = join(getline(a:start, a:end), '\n')
				let cleaned_lines = substitute(shellescape(joined_lines), "'\\\\''", "\\\\'", 'g')
				let output = systemlist(cmd . " <<< $" . cleaned_lines)
				endif
			else
				redir => output
				execute a:cmd
				redir END
				let output = split(output, "\n")
				endif
				vnew
				let w:scratch = 1
				setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
				call setline(1, output)
				endfunction

				" This command definition includes -bar, so that it is possible to "chain" Vim commands.
				" Side effect: double quotes can't be used in external commands
				" command! -nargs=1 -complete=command -bar -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)

				" This command definition doesn't include -bar, so that it is possible to use double quotes in external commands.
				" Side effect: Vim commands can't be "chained".
				command! -nargs=1 -complete=command -range Redir silent call Redir(<q-args>, <range>, <line1>, <line2>)
				]]

vim.cmd [[
" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
set grepprg=rg\ --vimgrep
function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END
]]

vim.cmd [[
" Tpope
autocmd VimResized * wincmd =
]]


vim.api.nvim_create_user_command("Vr", function(opts)
	local width = math.floor(vim.opt.columns:get() * opts.args / 100.0)
	vim.api.nvim_win_set_width(0, width)
end, { nargs = 1 })

vim.api.nvim_create_user_command("Hr", function(opts)
	local height = math.floor((vim.opt.lines:get() - vim.opt.cmdheight:get()) * opts.args / 100.0)
	vim.api.nvim_win_set_height(0, height)
end, { nargs = 1 })

local M = {}
local system = vim.uv.os_uname().sysname
local sshtty = vim.env.SSH_TTY
local tex = require("latex_snip.conditions.luasnip")
if sshtty then
	return
end

function M.modecond()
	return vim.api.nvim_get_mode().mode == "i" or vim.fn.getcmdtype() == "/" or vim.fn.getcmdtype() == "?"
end

function M.langcond()
	return vim.g.language == "zh"
end

function M.cursorcond()
	if vim.bo.filetype == "tex" or vim.bo.filetype == "latex" then
		return tex.in_text()
	else
		return true
	end
end
function M.refersh()
	if not vim.g.imselect_enabled then
		return
	end
	if M.modecond() and M.langcond() and M.cursorcond() then
		M.enableim()
	else
		M.disableim()
	end
end

if system == "Linux" then
	M.enableim = function()
		vim.cmd("silent !fcitx-remote -o")
	end
	M.disableim = function()
		vim.cmd("silent !fcitx-remote -c")
	end
elseif system == "Darwin" then
	local input_source = {
		zh = "im.rime.inputmethod.Squirrel.Hans",
		en = "com.apple.keylayout.ABC",
	}
	local change_command = vim.fn.executable("issw") and "issw -V "
		or vim.fn.executable("macism") and "macism "
		or error("No tool to change input method, install issw or macism!")
	M.enableim = function()
		vim.cmd("silent !" .. change_command .. input_source["zh"])
	end
	M.disableim = function()
		vim.cmd("silent !" .. change_command .. input_source["en"])
	end
else
	error("Imselect only support linux and mac now.")
end
vim.api.nvim_create_autocmd({ "ModeChanged", "CursorMovedI" }, {
	callback = M.refersh,
})

return M

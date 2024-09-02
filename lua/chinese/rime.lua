local cmd_with_output = require("util").cmd
local systemos = cmd_with_output("neofetch os", "Linux")
systemos = string.gsub(systemos, "os:", "")
systemos = string.gsub(systemos, "[^%a]", "")
vim.g.systemos = systemos
local sshtty = cmd_with_output("echo $SSH_TTY")
sshtty = string.gsub(sshtty, "%s", "")
if sshtty ~= "" then
	vim.g.ssh = true
else
	vim.g.ssh = false
end
local tex = require("util.conditions")
local get_magic_comment = require("latex.get_magic_comment")
local autocmd = vim.api.nvim_create_autocmd
-- vim.g.curenv == "text"
-- vim.g.curlang == "zh"
-- vim.g.mode == "i"
local get_curenv = function()
	if tex.in_math() then
		return "math"
	end
	if tex.in_preamble() then
		return "prea"
	end
	if tex.in_comment() then
		return "comm"
	end
	return "text"
end
autocmd("BufEnter", {
	pattern = "*.tex",
	callback = function()
		local language = get_magic_comment("language") or "en"
		vim.g.curlang = language
		vim.g.mode = vim.api.nvim_get_mode().mode
		vim.cmd("doautocmd User Changed")
	end,
})
vim.keymap.set({ "i", "n" }, "<C-x>", function()
	vim.g.curlang = (vim.g.curlang == "en") and "zh" or "en"
	vim.cmd("doautocmd User Changed")
end)

local updateenv = function()
	local oldenv = vim.g.curenv
	vim.g.curenv = get_curenv()
	if (vim.g.curenv ~= "text") and (oldenv == "text") then
		vim.cmd("doautocmd User Changed")
	end
	if (vim.g.curenv == "text") and (oldenv ~= "text") then
		vim.cmd("doautocmd User Changed")
	end
end
autocmd("CursorMovedI", {
	pattern = "*.tex",
	callback = updateenv,
})
autocmd("InsertEnter", {
	pattern = "*.tex",
	callback = updateenv,
})
if vim.g.systemos == "Linux" then
	local change_im = function()
		if vim.g.curlang == "zh" and vim.g.curenv == "text" and vim.g.mode == "i" then
			vim.cmd("silent !fcitx-remote -o")
		else
			vim.cmd("silent !fcitx-remote -c")
		end
	end
	autocmd("User", {
		pattern = "Changed",
		callback = change_im,
	})
end
if vim.g.systemos == "macOS" then
	local input_source = {
		zh = "im.rime.inputmethod.Squirrel.Hans",
		en = "com.apple.keylayout.ABC",
	}
	local change_im = function()
		if vim.g.curlang == "zh" and vim.g.curenv == "text" and vim.g.mode == "i" then
			vim.cmd("silent !macism " .. input_source["zh"])
		else
			vim.cmd("silent !macism " .. input_source["en"])
		end
	end
	autocmd("User", {
		pattern = "Changed",
		callback = change_im,
	})
end
autocmd("InsertLeavePre", {
	pattern = "*.tex",
	callback = function()
		vim.g.mode = "n"
		vim.cmd("doautocmd User Changed")
	end,
})
autocmd("InsertEnter", {
	pattern = "*.tex",
	callback = function()
		vim.g.mode = "i"
		vim.cmd("doautocmd User Changed")
	end,
})

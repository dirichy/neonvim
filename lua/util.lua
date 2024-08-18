local M = {}

---@param opt string #the option to set, must be a key of vim.opt
---@param on any #the value of vim.opt[opt] when option is on
---@param off any #the value of vim.opt[opt] when option is off
---@param name? string #the alias name of this option, will use in notify.
---when not provided, will be same as opt.
---@return function #will return a funtcion to toggle this option
function M.opt_toggle_fun(opt, on, off, name)
	local result = function()
		local message = name or opt
		if vim.opt[opt]:get() == off then
			vim.opt[opt] = on
			message = message .. " Enabled"
		else
			vim.opt[opt] = off
			message = message .. " Disabled"
		end
		vim.notify(message, vim.log.levels.INFO)
	end
	return result
end
return M

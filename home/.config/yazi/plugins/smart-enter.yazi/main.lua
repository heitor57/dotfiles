--- @sync entry

local function setup(self, opts)
	self.open_multi = opts.open_multi
end

local function entry(self)
	local h = cx.active.current.hovered

	if h and h.cha.is_dir then
		os.execute('zoxide add "' .. tostring(h.url) .. '"')
	end
	ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = not self.open_multi })
end

return { entry = entry, setup = setup }

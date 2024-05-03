return {
	entry = function()
		local h = cx.active.current.hovered
		if h and h.cha.is_dir then
			os.execute('zoxide add "' .. tostring(h.url) .. '"')
		end
	end,
}

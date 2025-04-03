function ya.readable_size(size)
	local units = { "B", "K", "M", "G", "T", "P", "E", "Z", "Y", "R", "Q" }
	local base = 1000
	local i = 1
	while size > base and i < #units do
		size = size / base
		i = i + 1
	end
	return string.format("%.1f%s", size, units[i]):gsub("[.,]0", "", 1)
end

-- load interface for the cartridge
if (string.find(machine.images['cart']:filename(), 'boris25') ~= nil) then
	return load_interface("ggm_boris25")
elseif (string.find(machine.images['cart']:filename(), 'sandy') ~= nil) then
	return load_interface("ggm_sandy")
elseif (string.find(machine.images['cart']:filename(), 'steinitz') ~= nil) then
	return load_interface("ggm_steinitz")
end

return nil

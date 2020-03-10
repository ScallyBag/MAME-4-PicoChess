interface = {}

interface.level = "a2"
interface.cur_level = nil

function interface.setlevel()
	if (interface.cur_level == nil or interface.cur_level == interface.level) then
		return
	end
	interface.cur_level = interface.level
	local cols_idx = { a=1, b=2, c=3, d=4, e=5, f=6, g=7, h=8 }
	local x = cols_idx[interface.level:sub(1, 1)]
	if (x > 5) then
		return
	end
	local y = interface.level:sub(2, 2)
	send_input(":KEY", 0x10, 1)  -- LEVEL
	emu.wait(0.5)
	sb_press_square(":board:board", 1, x, y)
	emu.wait(0.5)
	send_input(":KEY", 0x80, 1) -- CLEAR
end

function interface.setup_machine()
	sb_reset_board(":board:board")

	-- CL + ENT for start a new game
	emu.wait(1)
	machine:ioport().ports[":KEY"]:field(0x80):set_value(1)
	machine:ioport().ports[":KEY"]:field(0x40):set_value(1)
	emu.wait(0.5)
	machine:ioport().ports[":KEY"]:field(0x40):set_value(0)
	machine:ioport().ports[":KEY"]:field(0x80):set_value(0)
	emu.wait(2)

	interface.cur_level = "a2"
	interface.setlevel()
end

function interface.start_play(init)
	send_input(":KEY", 0x40, 1) -- ENTER
end

function interface.is_selected(x, y)
	local xvals = { 0x77, 0x7c, 0x39, 0x5e, 0x79, 0x71, 0x3d, 0x76 }
	local yvals = { 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f }
	local d0 = machine:outputs():get_value("digit3") & 0x7f
	local d1 = machine:outputs():get_value("digit2") & 0x7f
	local d2 = machine:outputs():get_value("digit1") & 0x7f
	local d3 = machine:outputs():get_value("digit0") & 0x7f
	local xval = machine:outputs():get_indexed_value("led1", x - 1) ~= 0
	local yval = machine:outputs():get_indexed_value("led2", y - 1) ~= 0
	return (xvals[x] == d0 and yvals[y] == d1) or (xvals[x] == d2 and yvals[y] == d3) or (xval and yval)
end

function interface.select_piece(x, y, event)
	sb_select_piece(":board:board", 1, x, y, event)
end

function interface.get_options()
	return { { "string", "Level", "a2"}, }
end

function interface.set_option(name, value)
	if (name == "level" and value ~= "") then
		interface.level = value
		interface.setlevel()
	end
end

function interface.get_promotion(x, y)
	local d0 = machine:outputs():get_value("digit3") & 0x7f
	local d1 = machine:outputs():get_value("digit2") & 0x7f
	local d3 = machine:outputs():get_value("digit0") & 0x7f

	if (d0 == 0x73 and d1 == 0x50) then	-- display shows 'Pr'
		if     (d3 == 0x5e) then	return "q"
		elseif (d3 == 0x31) then	return "r"
		elseif (d3 == 0x38) then	return "b"
		elseif (d3 == 0x6d) then	return "n"
		end
	end

	return nil
end

function interface.promote(x, y, piece)
	sb_promote(":board:board", x, y, piece)
	if     (piece == "q") then	send_input(":KEY", 0x10, 1)
	elseif (piece == "r") then	send_input(":KEY", 0x08, 1)
	elseif (piece == "b") then	send_input(":KEY", 0x04, 1)
	elseif (piece == "n") then	send_input(":KEY", 0x02, 1)
	elseif (piece == "Q" or piece == "R" or piece == "B" or piece == "N") then
		sb_press_square(":board:board", 1, x, y)
	end
end

return interface

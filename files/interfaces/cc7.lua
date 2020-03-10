interface = {}

interface.turn = true
interface.invert = false
interface.level = 1
interface.cur_level = nil

function interface.setlevel()
	if (interface.cur_level == nil or interface.cur_level == interface.level) then
		return
	end
	interface.cur_level = interface.level
	local lcd_num = { 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07 }
	repeat
		send_input(":IN.3", 0x02, 0.5) -- LV
	until machine:outputs():get_value("digit3") == lcd_num[interface.level]
	send_input(":IN.1", 0x01, 0.5) -- CL
end

function interface.setup_machine()
	interface.turn = true
	interface.invert = false
	send_input(":IN.1", 0x01, 1) -- CL
	emu.wait(1.0)

	interface.cur_level = 1
	interface.setlevel()
end

function interface.start_play(init)
	if (init) then
		interface.invert = false
		interface.turn = false
		send_input(":IN.2", 0x01, 0.5) -- CB
	end
end

function interface.is_selected(x, y)
	if (interface.invert) then
		x = 9 - x
		y = 9 - y
	end
	local xval = { 0x77, 0x7c, 0x39, 0x5e, 0x79, 0x71, 0x6f, 0x76 }
	local yval = { 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f }
	local d0 = machine:outputs():get_value("digit0")
	local d1 = machine:outputs():get_value("digit1")
	local d2 = machine:outputs():get_value("digit2")
	local d3 = machine:outputs():get_value("digit3")
	return (xval[x] == d0 and yval[y] == d1) or (xval[x] == d2 and yval[y] == d3)
end

function interface.send_pos(p)
	if     (p == 1)	then	send_input(":IN.3", 0x04, 1)
	elseif (p == 2)	then	send_input(":IN.2", 0x04, 1)
	elseif (p == 3)	then	send_input(":IN.1", 0x04, 1)
	elseif (p == 4)	then	send_input(":IN.0", 0x04, 1)
	elseif (p == 5)	then	send_input(":IN.3", 0x08, 1)
	elseif (p == 6)	then	send_input(":IN.2", 0x08, 1)
	elseif (p == 7)	then	send_input(":IN.1", 0x08, 1)
	elseif (p == 8)	then	send_input(":IN.0", 0x08, 1)
	end
end

function interface.select_piece(x, y, event)
	if (interface.invert) then
		x = 9 - x
		y = 9 - y
	end
	if (event ~= "capture" and event ~= "get_castling" and event ~= "put_castling" and event ~= "en_passant") then
		if (interface.turn) then
			interface.send_pos(x)
			interface.send_pos(y)
		end

		if (event == "put") then
			if (interface.turn) then
				send_input(":IN.0", 0x01, 1) -- EN
			end
			interface.turn = not interface.turn
		end
	end
end

function interface.get_options()
	return { { "spin", "Level", "1", "1", "7"}, }
end

function interface.set_option(name, value)
	if (name == "level") then
		local level = tonumber(value)
		if (level < 1 or level > 7) then
			return
		end
		interface.level = level
		interface.setlevel()
	end
end

function interface.get_promotion(x, y)
	return 'q'	-- TODO
end

function interface.promote(x, y, piece)
	-- TODO
end

return interface

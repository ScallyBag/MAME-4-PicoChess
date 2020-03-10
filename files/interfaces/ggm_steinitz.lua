interface = {}

interface.turn = true
interface.color = "B"
interface.level = "1"
interface.cur_level = nil
local computing

function interface.setlevel()
	if (interface.cur_level == nil or interface.cur_level == interface.level) then
		return
	end
	interface.cur_level = interface.level
	send_input(":IN.3", 0x01, 0.25) -- LEVEL
        emu.wait(0.25)
        local level = interface.level
        if (level:sub(1,2) == "10") then
                send_input(":IN.2", 0x08, 0.25) -- TIME
                level = level:sub(3)
        end
        local k = 0
        for i=1,level:len() do
                local d = level:sub(i,i)
                if (d == " " or d == "/") then
                        if (k == 5) then
                                break
                        end
                        send_input(":IN.3", 0x08, 0.25) -- TIMING
                        k = k + 1
                elseif (string.match(d,"%d")) then
                        if (tonumber(d) <= 4) then
                                send_input(":IN.0", 1 << d, 0.5)
                        elseif (tonumber(d) <= 9) then
                                send_input(":IN.1", 1 << (d-5), 0.5)
                        end
                end
        end
	send_input(":IN.3", 0x10, 0.25) -- ENTER
end

function interface.setup_machine()
	interface.turn = true
	interface.color = "B"
	emu.wait(3)

	interface.cur_level = "1"
	interface.setlevel()
end

function interface.start_play(init)
	send_input(":IN.2", 0x02, 0.5) -- B/W
	if (interface.color == "W") then
		interface.color = "B"
	else
		interface.color = "W"
	end
	emu.wait(0.25)
	interface.turn = false
end

function interface.stop_play()
        if (not interface.turn) then
                send_input(":IN.3", 0x02, 0.5) -- HALT
                emu.wait(0.25)
        end
end

function interface.is_selected(x, y)
        if (x == 1 and y == 1) then
                computing = false
                for i=1,4 do
                        if (machine:outputs():get_value("digit7") == 0) then
                                computing = true
                                return false
                        elseif (i<4) then
                                emu.wait(0.25)
                        end
                end
	elseif (computing) then
                return false
	end
	local xval = { 0x0f7, 0x3cf, 0x039, 0x30f, 0x0f9, 0x0f1, 0x0bd, 0x0f6 }
	local yval = { 0x300, 0x0db, 0x0cf, 0x0e6, 0x0ed, 0x0fd, 0x007, 0x0ff }
	local d0 = machine:outputs():get_value("digit7")
	local d1 = machine:outputs():get_value("digit6")
	local d2 = machine:outputs():get_value("digit5")
	local d3 = machine:outputs():get_value("digit4")
	local d4 = machine:outputs():get_value("digit3")
	return ((xval[x] == d0 and yval[y] == d1) or (xval[x] == d3 and yval[y] == d4))
end

function interface.send_pos(p)
	if     (p == 1)	then	send_input(":IN.0", 0x02, 0.5)
	elseif (p == 2)	then	send_input(":IN.0", 0x04, 0.5)
	elseif (p == 3)	then	send_input(":IN.0", 0x08, 0.5)
	elseif (p == 4)	then	send_input(":IN.0", 0x10, 0.5)
	elseif (p == 5)	then	send_input(":IN.1", 0x01, 0.5)
	elseif (p == 6)	then	send_input(":IN.1", 0x02, 0.5)
	elseif (p == 7)	then	send_input(":IN.1", 0x04, 0.5)
	elseif (p == 8)	then	send_input(":IN.1", 0x08, 0.5)
	end
end

function interface.select_piece(x, y, event)
	if (event ~= "capture" and event ~= "get_castling" and event ~= "put_castling" and event ~= "en_passant") then
		if (interface.turn) then
			interface.send_pos(x)
			interface.send_pos(y)
		end

		if (event == "put") then
			if (interface.turn) then
				send_input(":IN.3", 0x10, 0.5) -- ENTER
				emu.wait(0.25)
			end
			interface.turn = not interface.turn
		end
	end
end

function interface.get_options()
	return { { "string", "Level", "1"}, }
end

function interface.set_option(name, value)
	if (name == "level") then
                local level = value:match("^%s*(.-)%s*$"):gsub("%s%s+"," ") -- trim 
		if (level:sub(1,3) ~= "10 ") then
                        level = tonumber(level)
                        if (level == nil or level < 0 or level > 10) then
                                return
                        end
                        level = tostring(level)
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

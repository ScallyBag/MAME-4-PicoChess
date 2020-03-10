interface = {}

interface.level = "40/2:00 moves/hrs"
interface.cur_level = nil
interface.levelnum = 2

function setdigits(n)
        local dram = machine.devices[':lcd:lcdc'].spaces['display']
        send_input(":IN.3", 0x20, 0.2) -- Enter
        for i=1,n do
                if (n == 7 and (i == 3 or i == 5)) then
                        -- skip char
                else
                        local k = tonumber(interface.level:sub(i,i)) - (dram:read_u8(0x119+i)-0x10)
                        if (n == 7 and i == 6) then
                                if (k > 3) then
                                        k = k - 6
                                elseif (k < -3) then
                                        k = k + 6
                                end
                        else
                                if (k > 5) then
                                        k = k - 10
                                elseif (k < -5) then
                                        k = k + 10
                                end
                        end
                        for j=1,math.abs(k) do
                                if (k > 0) then
                                        send_input(":IN.2", 0x40, 0.2) -- up
                                else
                                        send_input(":IN.3", 0x40, 0.2) -- down
                                end
                        end
                        if (i < n) then
                                send_input(":IN.1", 0x40, 0.2) -- right
                        end
                end
        end
end

function interface.setlevel()
	if (interface.cur_level == nil or interface.cur_level == interface.level or interface.levelnum == 0) then
		return
	end
	interface.cur_level = interface.level
	send_input(":IN.2", 0x20, 0.2) -- Menu
        send_input(":IN.1", 0x40, 0.2) -- right
        send_input(":IN.3", 0x40, 0.2) -- down
        send_input(":IN.1", 0x40, 0.2) -- right
        if (interface.levelnum == 1) then
                send_input(":IN.2", 0x40, 0.2) -- up
                setdigits(3)
        elseif (interface.levelnum == 2) then
                setdigits(7)
        elseif (interface.levelnum == 3) then
                send_input(":IN.3", 0x40, 0.2) -- down
                setdigits(2)
        elseif (interface.levelnum == 4) then
                send_input(":IN.3", 0x40, 0.2) -- down
                send_input(":IN.3", 0x40, 0.2) -- down
                setdigits(2)
        elseif (interface.levelnum == 5) then
                send_input(":IN.3", 0x40, 0.2) -- down
                send_input(":IN.3", 0x40, 0.2) -- down
                send_input(":IN.3", 0x40, 0.2) -- down
                setdigits(2)
        elseif (interface.levelnum == 6) then
                send_input(":IN.3", 0x40, 0.2) -- down
                send_input(":IN.3", 0x40, 0.2) -- down
                send_input(":IN.3", 0x40, 0.2) -- down
                send_input(":IN.3", 0x40, 0.2) -- down
        end
        send_input(":IN.3", 0x20, 0.2) -- Enter
        send_input(":IN.2", 0x20, 0.2) -- Menu
end

function interface.setup_machine()
	sb_reset_board(":smartboard:board")
	emu.wait(3)

	interface.cur_level = ""
        interface.setlevel()
end

function interface.start_play(init)
	send_input(":IN.0", 0x20, 0.5)	-- PLAY
end

function interface.is_selected(x, y)
	local led0 = machine:outputs():get_value("led_" .. tostring(8 - y) .. tostring(8 - x)) == 1
	local led1 = machine:outputs():get_value("led_" .. tostring(8 - y) .. tostring(9 - x)) == 1
	local led2 = machine:outputs():get_value("led_" .. tostring(9 - y) .. tostring(8 - x)) == 1
	local led3 = machine:outputs():get_value("led_" .. tostring(9 - y) .. tostring(9 - x)) == 1
	return led0 and led1 and led2 and led3
end

function interface.select_piece(x, y, event)
	sb_select_piece(":smartboard:board", 1, x, y, event)
end

function interface.get_options()
	return { { "string", "Level", "40/2:00 moves/hrs"}, }
end

function interface.set_option(name, value)
	if (name == "level" and value ~= "") then
                local temp = string.upper(value)
                interface.levelnum = 0
                if ((string.match(temp,"%d%d?%d?%s+SEC/MOVE")) or (string.match(temp,"%d%d?%d?%s+SE[KC]/ZUG"))) then
                        if (temp:sub(3,3) == " ") then
                                value = "0" .. value
                        elseif (temp:sub(2,2) == " ") then
                                value = "00" .. value
                        end
                        interface.levelnum = 1
                elseif ((string.match(temp,"%d%d/%d:[0-5]%d%s+MOVES/HRS")) or (string.match(temp,"%d%d/%d:[0-5]%d%s+Z[��]GE/STD"))) then
                        interface.levelnum = 2
                elseif ((string.match(temp,"%d%d?%s+MIN/GAME")) or (string.match(temp,"%d%d?%s+MIN/PARTIE"))) then
                        if (temp:sub(2,2) == " ") then
                                value = "0" .. value
                        end
                        interface.levelnum = 3
                elseif ((string.match(temp,"%d%d?%s+PLY")) or (string.match(temp,"%d%d?%s+HALBZUG"))) then
                        if (temp:sub(2,2) == " ") then
                                value = "0" .. value
                        end
                        interface.levelnum = 4
                elseif ((string.match(temp,"%d%d?%s+MATE")) or (string.match(temp,"%d%d?%s+MATT"))) then
                        if (temp:sub(2,2) == " ") then
                                value = "0" .. value
                        end
                        interface.levelnum = 5
                elseif ((string.match(temp,"INFINITE")) or (string.match(temp,"UNENDLICH"))) then
                        interface.levelnum = 6
                end
                if (interface.levelnum ~= 0) then
                        interface.level = value
                        interface.setlevel()
                end
	end
end

function interface.get_promotion(x, y)
        local dram = machine.devices[':lcd:lcdc'].spaces['display']
        local addr = 0x133
        local byte = 0
        repeat
                addr = addr - 1
                byte = dram:read_u8(addr)
        until (byte ~= 0x80 and byte ~= 0xf2 and byte ~= 0xf3)
        if     (byte == 0xed) then return 'q'
        elseif (byte == 0xee) then return 'r'
        elseif (byte == 0xef) then return 'b'
        elseif (byte == 0xf0) then return 'n'
        end
end

function interface.promote(x, y, piece)
	sb_promote(":smartboard:board", x, y, piece)
	local right = -1
	if     (piece == "q") then right = 0
	elseif (piece == "r") then right = 1
	elseif (piece == "b") then right = 2
	elseif (piece == "n") then right = 3
	end
	if (right ~= -1) then
		for i=1,right do
			send_input(":IN.1", 0x40, 0.5)	-- RIGHT
		end
		send_input(":IN.3", 0x20, 0.5)	-- ENTER
	end
end

return interface

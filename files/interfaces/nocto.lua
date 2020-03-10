interface = load_interface("npresto")

function interface.setlevel()
	if (interface.cur_level == nil or interface.cur_level == interface.level) then
		return
	end
	interface.cur_level = interface.level
        send_input(":IN.0", 0x10, 0.3) -- Set Level
        emu.wait(0.2)
        local k = 8
        while machine:outputs():get_indexed_value("0.", k - 1) == 0 do
                k = k - 1
        end
	k = (interface.level - k + 8) % 8
	for i=1,k do
		send_input(":IN.0", 0x10, 0.3) -- Set Level
        end
end

function interface.start_play(init)
	emu.wait(1)
	send_input(":IN.0", 0x80, 0.3) -- Go
end

function interface.select_piece(x, y, event)
	if (event == "en_passant") then
		sb_remove_piece(":board", x, y)
	elseif (event == "get_castling" or event == "put_castling") then
		sb_move_piece(":board", x, y)
	else
		sb_select_piece(":board", 0.3, x, y, event)
	end
end

return interface

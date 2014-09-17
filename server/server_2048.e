note
	description: "Summary description for {SERVER_2048}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SERVER_2048

create
	make

feature -- Creation

		-- Sets up the server and port for listening requests.
		-- Runs the main server loop.

	make (argv: ARRAY [STRING])
			-- Accept communication with client and exchange messages
		local
			count: INTEGER
			soc1: detachable NETWORK_STREAM_SOCKET
		do
			if argv.count /= 2 then
				io.error.putstring ("Usage: ")
				io.error.putstring (argv.item (0))
				io.error.putstring (" portnumber%N")
			else
				create soc1.make_server_by_port (argv.item (1).to_integer)
				from
					soc1.listen (5)
					count :=0
				until
					count =1
				loop
					process (soc1) -- See below
				end
				soc1.cleanup
			end
		rescue
			if soc1 /= Void then
				soc1.cleanup
			end
		end

	process (soc1: NETWORK_STREAM_SOCKET)
			-- Accepts communication and exchanges messages with client.
		do
		end

	handle_begin_msg : BOOLEAN
			-- Handles the reception of a "Begin" message
		do
			if not (playing) then
				create controller.make
				playing := True
			end
			Result := playing
		end

	handle_up_msg
			-- Handles the reception of a "Up" message
		do
		end

	handle_down_msg
			-- Handles the reception of a "Down" message
		do
		end

	handle_left_msg: BOOLEAN
			-- Handles the reception of a "Left" message
		do

			if playing then
				if controller.board.can_move_left then
					controller.left
				    Result := True
				else
					Result := False
				end
			else
				Result := False
			end
		end

	handle_right_msg: BOOLEAN
			-- Handles the reception of a "Right" message
		do
			if playing then
				if controller.board.can_move_right then
					controller.right
					Result := True
				else
					Result := False
				end
			else
				Result := False
			end
		end

	handle_end_msg:BOOLEAN
			-- Handles the reception of a "End" message
		do
			if playing then
				playing := False
				controller := Void
				Result := True
			else
				Result := False
			end
		ensure
			playing = False
		end

feature {NONE}

	controller: CONTROLLER_2048

	playing: BOOLEAN

end

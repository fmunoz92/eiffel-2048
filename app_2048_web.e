note
	description: "[
						This class implements the `Hello World' service.
		
						It inherits from WSF_DEFAULT_RESPONSE_SERVICE to get default EWF connector ready
						only `response' needs to be implemented.
						In this example, it is redefined and specialized to be WSF_PAGE_RESPONSE
		
						`initialize' can be redefine to provide custom options if needed.
	]"

class
	APP_2048_WEB

inherit

	WSF_DEFAULT_RESPONSE_SERVICE
		redefine
			initialize
		end

create
	make_and_launch

feature
	controller: CONTROLLER_2048
	is_attached : BOOLEAN

feature {NONE} -- Execution

	response (req: WSF_REQUEST): WSF_HTML_PAGE_RESPONSE
			-- Computed response message.
		do
			create Result.make

			if not is_attached then
				is_attached := true
				create controller.make
				Result.set_body (controller.board.out)
			else

				if attached req.string_item ("q") as command then
					if command.is_equal ("w") then
						if controller.board.can_move_up then
							controller.up
						end
					end
					if command.is_equal ("s") then
						if controller.board.can_move_down then
							controller.down
						end
					end
					if command.is_equal ("a") then
						if controller.board.can_move_left then
							controller.left
						end
					end
					if command.is_equal ("d") then
						if controller.board.can_move_right then
							controller.right
						end
					end

					if controller.board.is_winning_board then
						Result.set_body ("{status: 'win'}")
					else
						if not controller.board.can_move_up and not controller.board.can_move_down and not controller.board.can_move_left and not controller.board.can_move_right then
							Result.set_body ("{status: 'lose'}")
						else
							Result.set_body (controller.board.out)
						end
					end
				end
			end

				--| note:
				--| 1) Source of the parameter, we could have used
				--|		 req.query_parameter ("user") to search only in the query string
				--|		 req.form_parameter ("user") to search only in the form parameters
				--| 2) response type
				--| 	it could also have used WSF_PAGE_REPONSE, and build the html in the code
				--|

		end

feature {NONE} -- Initialization

	initialize
		do
				--| Uncomment the following line, to be able to load options from the file ewf.ini
			create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI} service_options.make_from_file ("ewf.ini")

				--| You can also uncomment the following line if you use the Nino connector
				--| so that the server listens on port 9999
				--| quite often the port 80 is already busy
				--			set_service_option ("port", 9999)

				--| Uncomment next line to have verbose option if available
				--			set_service_option ("verbose", True)

				--| If you don't need any custom options, you are not obliged to redefine `initialize'
			Precursor
		end

end

note
	description: "eiffel-2048 application root class, for command line version of the application."
	date: "August 26, 2014"
	revision: "0.01"

class
	STORE_CLASS

inherit

	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make -- Run application.
		do
		end



feature -- Implementation

	controller: CONTROLLER_2048
			-- It takes care of the control of the 2048 game.

	user: USER_2048
			-- it represents the current game session



feature {NONE} --create user, screen

	create_user(name:STRING,surnmame:STRING,nickname:STRING,password:STRING): BOOLEAN --true if user created, false if error.
	local
		valid_data : BOOLEAN
		new_user : USER_2048
		name, surname, nickname, password : STRING
	do
		create new_user.make_for_test
		valid_data := False
		if new_user.is_valid_name (name) and new_user.is_valid_name (surname) and new_user.is_valid_name (nickname) and new_user.is_valid_password (password) then --validate the data
				if not  new_user.existing_file (nickname) then
					valid_data := True
				else
					valid_data := False
				end

		create new_user.make_new_user (name, surname,nickname,password)
		new_user.set_logged_in

		Result:=valid_data
	end

	login_user (username: STRING; password: STRING)
			-- validate the user datas
			-- load the user from the file into the user variable, or void if the user doesn't exist
		require
			(create {USER_2048}.make_for_test).is_valid_nickname (username) and password /= Void
		local
			possible_user: USER_2048
		do
			create possible_user.make_with_nickname (username)
			if possible_user.has_unfinished_game then
				possible_user.load_game
				if equal(password, possible_user.password) then
					user := possible_user
					user.set_logged_in
				else
					user := Void
				end
			else
				user := Void
			end
		end

	save_game (username:STRING, password: STRING)

		require
			(create {USER_2048}.make_for_test).is_valid_nickname (username) and password /= Void
		local
			possible_user: USER_2048
		do
			create possible_user.make_with_nickname (username)
			if possible_user.has_unfinished_game then
				possible_user.load_game
				if equal(password, possible_user.password) then
					user := possible_user
				else
					user := Void
				end

				user.save_game (controller.board)
				user.set_logged_out
			else
				user := Void
			end
		end


	quit_game (username:STRING, password: STRING)

		require
			(create {USER_2048}.make_for_test).is_valid_nickname (username) and password /= Void
		local
			possible_user: USER_2048
		do
			create possible_user.make_with_nickname (username)
			if possible_user.has_unfinished_game then
				possible_user.load_game
				if equal(password, possible_user.password) then
					user := possible_user
				else
					user := Void
				end

				user.destroy_game (controller.board)
				user.set_logged_out
			else
				user := Void
			end
		end









end

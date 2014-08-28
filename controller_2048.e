note
	description: "This class takes care of the control of the game."
	author: ""
	date: "August 25, 2014"
	revision: "0.01"

class
	CONTROLLER_2048

create
	make, make_with_board

feature -- Initialisation

	make_with_board (new_board: BOARD_2048)
			-- Creates a controller with reference to a provided board
		require
			new_board /= Void
		do
			board := new_board
		ensure
			board = new_board
		end

	make
			-- Creates a controller from scratch. The controller must create the
			-- classes that represent and take care of the logic of the game.

		do
			last_random_cell_coordinates := [0, 0]
			create board.make
		ensure
			board /= Void
		end

feature -- Game State

	board: BOARD_2048
			-- Reference to the object that maintains the state of the game
			-- and takes care of the games logic.

	is_finished: BOOLEAN
			-- Indicates whether the game is finished or not.
			-- Game finishes when either 2048 is reached, or if any movement is possible.
		local
			i, j: INTEGER -- Auxiliary variables to navigate through the game board
			finished: BOOLEAN -- Auxiliary variable to capture the finalization desicion
		do
			finished := False
			if not board.can_move_up and not board.can_move_down and not board.can_move_left and not board.can_move_right then
				Result := True
			else
				from
					j := 1
				until
					j = 4
				loop
					from
						i := 1
					until
						i = 4 or finished = True
					loop
						finished := board.elements.item (i, j).value = 2048
						i := i + 1
					end
					j := j + 1
				end
			end
			Result := finished
		end

	last_random_cell_coordinates: TUPLE [INTEGER, INTEGER]
			-- Returns the coordinates of th last randomly introduced
			-- cell. Value should be (0,0) if no cell has been introduced in the last movement
			-- or if the game state is the initial state.

feature -- Movement commands

	up
			-- Moves the cells to the uppermost possible point of the game board.
			-- Movement colapses cells with the same value.
			-- It adds one more random cell with value 2 or 4, after the movement.
		local
			-- i, v, j: INTEGER
		do
				-- UPDATE NOT USING GET_VALUE, WHICH IS OBSOLETE
				--			from
				--				j := 1
				--			until
				--				j = 4
				--			loop
				--				from
				--					i := 4
				--				until
				--					i = 1
				--				loop
				--
				--					if board.elements.item (i, j).get_value /= 0 then
				--						if (i - 1 > 0) and (board.elements.item (i - 1, j).get_value /= 0) then
				--							if board.elements.item (i, j).get_value = board.elements.item (i - 1, j).get_value then
				--								v := board.elements.item (i, j).get_value + board.elements.item (i - 1, j).get_value
				--								board.set_cell (i - 1, j, v)
				--								i := i - 1
				--							end
				--						else
				--							if (i - 2 > 0) and (board.elements.item (i - 2, j).get_value /= 0) then
				--								if board.elements.item (i, j).get_value = board.elements.item (i - 2, j).get_value then
				--									v := board.elements.item (i, j).get_value + board.elements.item (i - 2, j).get_value
				--									board.set_cell (i - 2, j, v)
				--									i := i - 1
				--								else
				--									board.set_cell (i - 1, j, board.elements.item (i, j).get_value)
				--									i := i - 1
				--								end
				--							else
				--								if (i - 3 > 0) and (board.elements.item (i - 3, j).get_value /= 0) then
				--									if board.elements.item (i, j).get_value = board.elements.item (i - 3, j).get_value then
				--										v := board.elements.item (i, j).get_value + board.elements.item (i - 3, j).get_value
				--										board.set_cell (i - 3, j, v)
				--										i := i - 1
				--									else
				--										board.set_cell (i - 2, j, board.elements.item (i, j).get_value)
				--										i := i - 1
				--									end
				--								end
				--							end
				--						end
				--					end
				--				end --end from i
				--				j := j + 1
				--			end --end from j

				--			set_random_free_cell
		end --end do

	down --Command that moves the cells to the lowermost possible point of the game board

		local
			i ,j ,k : INTEGER
			bool : BOOLEAN

		do
			bool := False
			from
				i := 1
			until
				i >= 4
			loop -- columns
				from
					j := 1
				until
					j >= 4
				loop -- rows
					if board.elements.item (i, j).value /= 0 then
						k := j
						j := j+1
						from
							-- search for the next element /= 0
						until
							(j>4) and (board.elements.item (i, j) /= 0)
						loop
							j := j+1
						end
						if j<=4 then -- if search is succesful
							if board.elements.item (i, k).value = board.elements.item (i, j).value  then
								board.set_cell (i, j, (board.elements.item (i, k).value + board.elements.item (i, j).value))
								board.set_cell (i, k, 0)
								j := j+1
								bool := True
							end
						end
					else
						j := j+1
					end -- end if /=0
				end -- end loop j
				i := i+1
			end -- end loop i

			if bool = True then
				set_random_free_cell
			end
		end -- end do

	left
			-- Moves the cells to the leftmost possible point of the game board.
			-- Movement colapses cells with the same value.
			-- It adds one more random cell with value 2 or 4, after the movement.
		do
		end

	right
			-- Moves the cells to the rightmost possible point of the game board.
			-- Movement colapses cells with the same value.
			-- It adds one more random cell with value 2 or 4, after the movement.

		local
			i, j, v: INTEGER
		do
			from
			 	i := 1
			until
			 	i > 4
			loop
				from
					j := 4
				until
					j < 1
				loop
					if board.elements.item(i, j).value /= 0 then
					   if (j-1 > 0) and (board.elements.item(i, j-1).value /= 0) then
					      if board.elements.item(i, j).value = board.elements.item(i, j-1).value then
						     v := board.elements.item(i, j).value + board.elements.item(i, j-1).value
							 board.set_cell(i, j, 0)
							 board.set_cell(i, j-1, 0)
							 position_right(i, v)
							 j := j - 1
						  else
						     v := board.elements.item(i, j).value
						     board.set_cell(i, j, 0)
							 position_right(i, v)
							 j := j - 1
					  	  end
 					   else
						  if (j-2 > 0) and (board.elements.item(i, j-2).value /= 0) then
							 if board.elements.item(i, j).value = board.elements.item(i, j-2).value then
							    v := board.elements.item(i, j).value + board.elements.item(i, j-2).value
							    board.set_cell(i, j, 0)
							    board.set_cell(i, j-2, 0)
							    position_right(i, v)
							    j := j - 1
							 else
							 	v := board.elements.item(i, j).value
							    board.set_cell(i, j, 0)
							    position_right(i, v)
							    j := j - 1
							 end
						  else
							 if (j-3 > 0) and (board.elements.item(i, j-3).value /= 0) then
							    if board.elements.item(i, j).value = board.elements.item(i, j-3).value then
							       v := board.elements.item(i, j).value + board.elements.item(i, j-3).value
								   board.set_cell(i, j, 0)
								   board.set_cell(i, j-3, 0)
								   position_right(i, v)
								   j := j - 1
							    else
							       v := board.elements.item(i, j).value
							       board.set_cell(i, j, 0)
							       position_right(i, v)
						    	   j := j - 1
						    	end
						     else
						     	v := board.elements.item(i, j).value
						     	board.set_cell(i, j, 0)
						     	position_right(i, v)
						     	j := j - 1
							 end
					      end
					   end
					else
					   j := j - 1
            	    end
			    end --end loop i
                i := i + 1
			end --end loop j
			set_random_free_cell
		end --end do

feature {NONE} -- Auxiliary routines

	set_random_free_cell
			-- Sets an unset cell of the board with value 2 or 4
			-- Position of unset cell is chosen randomly.
			-- Value to set the cell (2 or 4) chosen randomly.
		local
			marca_zero   : BOOLEAN
			tx, ty       : INTEGER
			random_value : INTEGER
			positionx    : RANDOM
			positiony    : RANDOM
		do
			create positionx.make
			create positiony.make
			from
				marca_zero := False
			until
				marca_zero = True
			loop
				tx := positionx.next_random(3)
				tx := tx + 1
				ty := positiony.next_random(3)
				ty := ty + 1
				if board.elements.item(tx, ty).is_available then
				   random_value := calc_two_four
				   board.elements.item(tx, ty).set_value(random_value)
				   marca_zero := True
				end --end if
			end --end loop
		end --end do

	calc_two_four : INTEGER
		-- Insert randomly calculates whether two or four
		local
			random_value : INTEGER
			random       : RANDOM
		do
		    create random.make
		    random_value := random.next_random(5)
		    if random_value = 0 then
		       Result := 4
		    else
		       Result := 2
		    end
		ensure
			Result = 2 or Result = 4
		end

	position_right(row, val: INTEGER)
        -- Method that receives as a parameter a row, and verifies the position which is more to the right
        -- which is empty in that row and also inserts the value passed as parameter
		local
			column: INTEGER
		do
			from
			 	column := 4
			until
		 		column < 1
		 	loop
		 		if board.elements.item(row, column).value = 0 then
		 		   board.set_cell(row, column, val)
		 		   column := 0
		 		else
		 		   column := column - 1
		 		end --end if
		 	end --end loop
		end --end do		

end

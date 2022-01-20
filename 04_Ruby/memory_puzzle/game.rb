require_relative "card"
require_relative "board"
require_relative "human_player"
require_relative "computer_player"
require "byebug"

class Game
    def initialize(n, player)
        @game_board = Board.new(n)
        @previous_guess = nil   #previous had this as a card instance, need to change to a position
        @player = player
    end

    def get_player_input
        pos = nil

        until pos && is_valid?(pos[0], pos[1])
            pos = @player.get_input
        end

        pos
    end

    def play
        until @game_board.won?
            @game_board.render
            position = get_player_input
            val = @game_board.reveal(position)
            @player.receive_revealed_card(position, val)
            make_guess(position)
        end
        return "YAY YOU WON!"
    end

    def make_guess(position)
        @game_board.render #added
        first = position[0].to_i
        second = position[1].to_i
        if @previous_guess.nil?     #if this is the first guess
            @previous_guess = [first, second]
            @player.previous_guess = [first, second]
        else    #if this is the second guess
            if @game_board.grid[first][second].face_val != @game_board.grid[@previous_guess[0]][@previous_guess[1]].face_val
                sleep(2)
                @game_board.grid[@previous_guess[0]][@previous_guess[1]].hide
                @game_board.grid[first][second].hide
            else
                @player.receive_match(position, @previous_guess)
            end
            @previous_guess = nil
            @player.previous_guess = nil
        end
    end

    def is_valid?(num1, num2)
        return false if num1.nil? || num2.nil?
        pos1 = num1.to_i
        pos2 = num2.to_i
        return pos1 >= 0 && pos1 < @game_board.grid.length && pos2 >= 0 && pos2 < @game_board.grid.length && !@game_board.grid[pos1][pos2].face_up
    end
end

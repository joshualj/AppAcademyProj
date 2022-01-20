require_relative "board"
require "byebug"

class ComputerPlayer
    attr_accessor :matched_cards, :known_cards, :previous_guess
    def initialize(size)
        @board_size = size
        @known_cards = {}
        @matched_cards = {}
        @previous_guess = nil
    end

    def random
        x = rand(0...@board_size)
        y = rand(0...@board_size)
        position = [x,y]
        return position if @known_cards.keys.none? {|pos| pos == position}
        random
    end

    def has_guessable_known_cards?
        @known_cards.each do |pos, val|
            @known_cards.each do |pos2, val2|
                return true if pos != pos2 && val == val2 && !(@matched_cards.keys.include?(pos) || @matched_cards.keys.include?(pos2))   #matched_cards is giving me issues ###pos != pos2 && val == val2 && !(c.matched_cards[pos] || c.matched_cardsp=[pos2])
            end
        end
        return false
    end

    def get_input
        if @previous_guess.nil?    #if this is the first guess, go here
            if has_guessable_known_cards?
                single_hash = @known_cards.find {|pos, val| @known_cards.any? {|pos2, val2| (pos != pos2 && val == val2) && !(@matched_cards.keys.include?(pos) || @matched_cards.keys.include?(pos2))}}
                return single_hash[0]   #single_hash is an array of size 2. The first value is a position, the second is a value
            else
                return random
            end
        else        #if this is the second guess, go here
            if @known_cards.any? {|pos, value| pos != @previous_guess && @known_cards[@previous_guess] == value}##if any k_v pair contains the same value as previous guess but diff position
                single_hash = @known_cards.find {|pos, val| pos != @previous_guess && val == @known_cards[@previous_guess] && !@matched_cards[pos]}
                @previous_guess = nil
                return single_hash[0]
            else
                @previous_guess = nil
                return random
            end
        end
    end

    def receive_revealed_card(position, value)
        @known_cards[position] = value
    end

    def receive_match(position1, position2)
        @matched_cards[position1] = true
        @matched_cards[position2] = true
    end
end

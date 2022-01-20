class HumanPlayer
    attr_accessor :previous_guess
    def initialize(size)
        @board_size = size
        @previous_guess = nil
        @known_cards = {} #Hash.new {|h,k| h[k]= []} #keys are positions, values are face_values
        @matched_cards = {}
    end

    def prompt
        print "Please enter the position of the card you'd like to flip (for example, '2,3') "
        return gets.chomp.split(",")
    end

    def get_input
        return prompt.map {|ele| ele.to_i}
    end

    def receive_revealed_card(position, value)
        @known_cards[position] = value #maybe try this instead
    end

    def receive_match(position1, position2)
        @matched_cards[position1] = true
        @matched_cards[position2] = true
    end

end

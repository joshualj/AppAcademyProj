require_relative "card"

class Board
    attr_reader :grid
    def initialize(n)
        @grid = Array.new(n) {Array.new(n,[])}
        populate
    end

    def populate
        pairs_count = (@grid.length * @grid.length) / 2
        alpha = ("A".."Z").to_a
        singles = []

        until singles.length == pairs_count #Adds random letter to an array, singles, that will be later used to create pairs
            possible_single = alpha.sample
            singles << possible_single unless singles.include?(possible_single)
        end
        pairs = singles + singles   #pairs is singles + singles

        @grid.each.with_index do |row, idx|     #iterates through each position of @grid, adds a random face_value from pairs to the current position, then deletes that face_value from "pairs"
            row.each.with_index do |pos, i|
                face_val = pairs.sample
                @grid[idx][i] = Card.new(face_val)
                pairs = pairs[0...pairs.index(face_val)] + pairs[pairs.index(face_val) + 1..-1]
            end
        end
        return @grid
    end

    def render
        system("clear")
        print "  "
        (0...@grid.length).each {|num| print "#{num} "}
        i = 0
        @grid.each.with_index do |row, idx|
            print "\n#{i}"
            row.each.with_index do |card, i|
                print " #{@grid[idx][i].display}"
            end
            i += 1
        end
        print "\n"
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def reveal(guessed_pos)
        @grid[guessed_pos[0]][guessed_pos[1]].reveal #unless @grid[guessed_pos[0]][guessed_pos[1]].face_up
    end

    def to_a
        self.map {|ele| ele}
    end

    def won?
        @grid.each.with_index do |row, idx|
            row.each.with_index do |card, i|
                return false unless @grid[idx][i].face_up
            end
        end
        return true
    end

end

class Card
    attr_reader :face_val, :face_up
    def initialize(face_val)
        @face_val = face_val
        @face_up = false
    end

    def display
        @face_up == false ? self.hide : self.reveal
    end

    def hide
        @face_up = false
        return " "
    end

    def reveal
        @face_up = true
        return @face_val
    end

    def to_s
        return "#{@face_val}"
    end

end

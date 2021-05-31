require_relative 'slidable'
require_relative 'piece_parent'

class Queen < Piece
    include Slidable
    attr_reader :symbol

    def initialize(color, board, pos)
        @symbol = "Q"
        super
    end

    def symbol
        @symbol.colorize(color)
    end

    def move_type
        diagonal + lateral
    end
end
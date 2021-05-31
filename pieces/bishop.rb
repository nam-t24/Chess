require_relative 'slidable'
require_relative 'piece_parent'

class Bishop < Piece
    include Slidable
    attr_reader :symbol

    def initialize(color, board, pos)
        @symbol = "b"
        super
    end

    def symbol
        @symbol.colorize(color)
    end

    def move_type
        diagonal
    end
end
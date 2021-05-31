require_relative 'slidable'
require_relative 'piece_parent'

class Rook < Piece
    include Slidable
    attr_reader :symbol

    def initialize(color, board, pos)
        @symbol = "r"
        super
    end
    
    def symbol
        @symbol.colorize(color)
    end

    def move_type
        lateral
    end
end
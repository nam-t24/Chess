require_relative 'stepable'
require_relative 'piece_parent'

class King < Piece
    include Stepable
    attr_reader :symbol
    def initialize(color, board, pos)
        @symbol = "K"
        super
    end

    def symbol
        @symbol.colorize(color)
    end

    def move_type
        [
            [0,1],
            [1,1],
            [1,0],
            [1,-1],
            [0,-1],
            [-1,-1],
            [-1,0],
            [-1,1]
        ]
    end

end
require_relative 'stepable'
require_relative 'piece_parent'
class Knight < Piece
    include Stepable
    attr_reader :symbol
    def initialize(color, board, pos)
        @symbol = "k"
        super
    end

    def symbol
        @symbol.colorize(color)
    end

    def move_type
        [
            [1,2],
            [2,1],
            [2,-1],
            [1,-2],
            [-1,-2],
            [-2,-1],
            [-2,1],
            [-1,2]
        ]
    end
end
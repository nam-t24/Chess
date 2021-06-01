require 'singleton'
require_relative 'piece_parent'
class NullPiece < Piece
    # include Singleton
    attr_reader :symbol, :color
    def initialize
        @symbol= " "
        @color= :none

    end

    def empty?
        true
    end
    def moves
        []
    end

end
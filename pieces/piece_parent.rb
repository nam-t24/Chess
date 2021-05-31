require "colorize"
class Piece
  attr_reader :board, :color
  attr_accessor :pos
  def initialize(color, board, pos)
    raise 'invalid color' unless color==:blue || color==:red
    raise 'invalid position' unless board.valid_pos?(pos)

    @color=color
    @board=board
    @pos=pos

    @board.add_piece(self, pos)
  end

  def to_s
    "#{symbol}"
  end

  def inspect
    "#{symbol}"
  end

  def empty?
    false
    #null piece will be true
  end

  def symbol
    #overridden by subclass
  end

  def valid_moves
    moves.reject { |position| move_into_check?(position) }
  end

  def move_into_check?(end_pos)
    dub_board = board.dup
    dub_board.move_piece!(pos, end_pos)
    dub_board.in_check?(color)
  end
end
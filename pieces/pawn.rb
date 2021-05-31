require_relative 'piece_parent'
require "byebug"
class Pawn < Piece
    attr_reader :symbol
    def initialize(color, board, pos)
        @symbol = "i"
        super
    end

    def moves
        # puts "In pawn moves method"
        forward_steps+capture
        
    end

    def symbol
        @symbol.colorize(color)
    end

    def at_start_row?
        ((pos[0] == 6 if color == :red) || (pos[0] == 1 if color == :blue))
    end

    def forward_dir
        color == :red ? -1 : 1;
    end

    def forward_steps
        x,y = pos
        new_pos =[x+forward_dir(), y]
        # debugger
        return [] if ((!@board.empty?(new_pos)) || (!@board.valid_pos?(new_pos)));

        moves=[new_pos]
        double_step = [new_pos[0]+forward_dir,y]
        moves << double_step if @board.empty?(double_step) && at_start_row?;

        moves
    end

    def capture
        capture_moves=[]
        color==:red ? capture_moves = [[-1,1],[-1,-1]] : capture_moves = [[1,1],[1,-1]]
        x,y=pos
        capture_moves.map! do |move|
            [move[0]+x, move[1]+y]
        end
        capture_moves.select! do |new_pos|
            next false unless board.valid_pos?(new_pos);
            next false if board.empty?(new_pos);

            captured_piece = board[new_pos]
            captured_piece && captured_piece.color != color
        end
        capture_moves
    end
end
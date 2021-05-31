require "byebug"
require_relative 'load_pieces'

class Board
    attr_reader :board
    def initialize(new_board=true)
        @empty = NullPiece.instance
        @board= Array.new(8) {Array.new(8,@empty)}
        #filling board
        if(new_board==true)
            #creates the piece object but does not directly add into the board(piece object does that in initialization)
            #filling back(black) row
            back_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
            back_pieces.each_with_index do |piece, col_idx|
                pos=[0,col_idx]
                piece.new(:blue, self, pos)
            end
            #filling front(white) row
            back_pieces.each_with_index do |piece, col_idx|
                pos=[7,col_idx]
                piece.new(:red, self, pos)
            end
            #filling black pawns
            (0..7).each do |col_idx|
                pos=[1,col_idx]
                Pawn.new(:blue, self, pos)
            end
            #filling white pawns
            (0..7).each do |col_idx|
                pos=[6,col_idx]
                Pawn.new(:red, self, pos)
            end
        end
        "Board created"
    end

    def add_piece(piece, pos)
        self[pos]=piece
    end

    def [](pos)
        x,y=pos
        @board[x][y]
    end
    
    def []=(pos,value)
        x,y=pos[0],pos[1]
        @board[x][y]=value
    end

    def dup
        dup_board=Board.new(false)
        @board.each_with_index do |row, row_idx|
            row.each_with_index do |piece, col_idx|
                pos=[row_idx, col_idx]
                if !piece.empty?
                    piece.class.new(piece.color, dup_board, pos)
                end
            end
        end
        dup_board
    end

    def move_piece(curr_color, start_pos, end_pos)
        raise ("Must be your own color") if self[start_pos].color != curr_color;
        raise ("Cannot take your own color") if self[end_pos].color == curr_color;
        raise ("Invalid end position") if !self[start_pos].moves.include?(end_pos);
        raise ("You are in check, can't move like that") if !self[start_pos].valid_moves.include?(end_pos);

        raise ("Invalid start position") if !valid_pos?(start_pos);
        raise ("Start position is empty") if self[start_pos]==@empty;
        raise ("Invalid end position") if !valid_pos?(end_pos);

        move_piece!(start_pos, end_pos)
        
    end

    def move_piece!(start_pos, end_pos)
        raise 'piece cannot move like that' unless self[start_pos].moves.include?(end_pos)
        self[end_pos] = self[start_pos]
        self[start_pos]=@empty
        self[end_pos].pos=end_pos
    end

    def empty?(pos)
        self[pos]==@empty
    end

    def valid_pos?(pos)
        x,y = pos
        ((0...8).to_a.include?(x) && (0...8).to_a.include?(y))
    end

    #renders board with position coordinates
    def render
        puts "  #{(0..7).to_a.join(" ")}"
        @board.each_with_index do |row,idx|
            row_arr=[]
            row.each {|piece| row_arr << piece.symbol}
            puts "#{idx} #{row_arr.join(" ")}"
        end
        ""
    end
    def to_s
        ""
    end

    def find_king(color)
        @board.each_with_index do |row, row_idx|
            row.each_with_index do |piece, col_idx|
                pos = [row_idx, col_idx]
                return pos if (piece.is_a?(King) && piece.color==color);
            end
        end
        nil
    end

    def in_check?(color)
        king_pos = find_king(color)
        @board.each_with_index do |row, row_idx|
            row.each_with_index do |piece, col_idx|
                if(piece.color != color)
                    return true if piece.moves.include?(king_pos);
                end
            end
        end
        false
    end

    def checkmate?(color)
        return false if !in_check?(color);

        same_color_pieces=[]
        @board.each do |row|
            row.each do |piece|
                if(piece.color == color)
                    same_color_pieces << piece
                end
            end
        end
        same_color_pieces.all? do |piece|
            piece.valid_moves.empty?
        end
    end
end

# board=Board.new
# board.move_piece!([6,5],[5,5])
# board.move_piece!([6,6],[4,6])
# board.move_piece!([1,4],[2,4])
# board.move_piece!([0,3],[4,7])
# board.render
# p board.checkmate?(:blue)



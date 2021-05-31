require "byebug"
module Slidable
    LATERAL=[
        [0,1],
        [1,0],
        [0,-1],
        [-1,0]
    ].freeze

    DIAGONAL=[
        [1,1],
        [1,-1],
        [-1,-1],
        [-1,1]
    ].freeze

    def lateral
        LATERAL
    end
    def diagonal
        DIAGONAL
    end

    def moves
        move_positions=[]
        move_type.each do |dx,dy|
            move_positions.concat(grow_unblocked_moves_in_dir(dy,dx))
        end
        move_positions
    end
    private
    def move_type
        # will be overridden, call diagonal or lateral
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        moves=[]
        xcurr, ycurr = pos
        valid = true
        while (valid)
            xcurr+=dx
            ycurr+=dy
            pos = [xcurr,ycurr]

            valid=true
            valid=false if !board.valid_pos?(pos);
            if(valid && board.empty?(pos))
                moves << pos
            elsif(valid)
                #takes opoonents piece, won't move pos into board if same color piece and will stop at pos before;
                moves << pos if board[pos].color != color;
                valid = false
            end
        end
        moves
    end

end
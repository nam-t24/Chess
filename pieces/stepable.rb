module Stepable
    def moves
        available_moves= move_type
        moves=[]
        available_moves.each do |dx,dy|
            xcurr, ycurr = pos
            new_pos=[xcurr+dx, ycurr+dy]
            #check if new position is valid
            next unless valid_pos?(new_pos)

            if(board.empty?(new_pos))
                moves<<new_pos
            elsif (board[new_pos].color != color)
                moves << new_pos
            end
        end
        moves
    end

    private
    def move_type
        #overwritten in class
        #gives an array of moves like lateral/diagonal
    end

    def valid_pos?(pos)
        x,y = pos
        ((0...8).to_a.include?(x) && (0...8).to_a.include?(y))
    end
end
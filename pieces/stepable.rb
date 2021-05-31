module Stepable
    def moves
        available_moves= move_type
        moves=[]
        available_moves.each do |dx,dy|
            xcurr, ycurr = pos
            new_pos=[xcurr+dx, ycurr+dy]
            #check if new position is valid
            next unless ((0..7).to_a.include?(new_pos[0]) && (0..7).to_a.include?(new_pos[1]))

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
end
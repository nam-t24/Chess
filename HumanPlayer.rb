require_relative 'Player'
require_relative 'display'

class HumanPlayer < Player

    def make_move(board)
        input=0
        start_pos = nil
        end_pos=nil
        until input == 2
            display.render

            if input==0
                puts "#{color} - Choose starting position"
                start_pos = @display.cursor.get_input
                return :escape if start_pos == :escape;
                display.reset! if start_pos
                input +=1 if start_pos != nil
            else
                puts "#{color} - Choose end position"
                end_pos = @display.cursor.get_input
                return :escape if end_pos == :escape;
                display.reset! if end_pos
                input +=1 if end_pos != nil
            end
        end
        [start_pos, end_pos]
    end
end
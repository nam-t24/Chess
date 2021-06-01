require "byebug"
require 'colorize'
require 'colorized_string'
require_relative 'board'
require_relative 'cursor'

class Display
    attr_reader :board, :cursor, :notifications

    def initialize(board)
        #@board is the entire board object not just the individual board
        @board=board
        @cursor=Cursor.new([0,0], board)
        @notifications={}
        @moves=[]
    end

    def reset!
        @notifications.delete(:error)
    end

    def uncheck!
        @notifications.delete(:check)
    end

    def set_check!
        @notifications[:check] = "Check!"
    end

    def render
        system("clear")
        puts "Use arrow keys or WASD to move, space or enter to confirm. (Ctrl + 'c' to exit)"
        puts "Press tab to toggle move options for selected piece; esc to save current game"
        # puts "Press esc to save current game"
        self.render_board
        @notifications.each do |_key, val|
            puts val
        end
    end
    
    #renders board only without other commands
    def render_board
        @board.board.each_with_index do |row,row_idx|
            row_arr=[]
            row.each {|piece| row_arr << piece.symbol}
            
            #move options
            if(cursor.toggle_move_options)
                #keeps move options for first input
                if(cursor.toggle_color == :light_cyan)
                    piece=board[cursor.cursor_pos]
                    @moves = piece.moves
                end
                @moves.each do |move_position|
                    if row_idx == move_position[0]
                        row_arr[move_position[1]] = row_arr[move_position[1]].colorize(background: :white)
                    end
                end
            end

            #cursor
            if row_idx == cursor.cursor_pos[0]
                row_arr[cursor.cursor_pos[1]] = row_arr[cursor.cursor_pos[1]].colorize(background: cursor.toggle_color)
            end

            puts "#{row_arr.join(" ")}"
        end
    end
end
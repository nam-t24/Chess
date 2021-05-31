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
        # puts "  #{(0..7).to_a.join(" ")}"
        system("clear")
        puts "Use arrow keys or WASD to move, space or enter to confirm. (Ctrl + 'c' to exit)"

        @board.board.each_with_index do |row,idx|
            row_arr=[]
            row.each {|piece| row_arr << piece.symbol}
            if idx == cursor.cursor_pos[0]
                row_arr[cursor.cursor_pos[1]] = row_arr[cursor.cursor_pos[1]].colorize(background: cursor.toggle_color)
            end
            puts "#{row_arr.join(" ")}"
        end
        @notifications.each do |_key, val|
            puts val
        end
    end
end
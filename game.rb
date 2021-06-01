require 'yaml'
require "byebug"
require_relative 'board'
require_relative 'display'
require_relative 'HumanPlayer'

class Game
    attr_reader :board, :display, :current_player, :players

    def initialize
        @board=Board.new
        @display=Display.new(@board)
        @players = {red: HumanPlayer.new(:red, @display),blue: HumanPlayer.new(:blue, @display)}
        @current_player = :red
    end

    def play
        until board.checkmate?(current_player)
            begin
                pos = players[current_player].make_move(board)
                save_game() if pos == :escape;
                start_pos, end_pos = pos
                board.move_piece(current_player, start_pos, end_pos)

                swap_turn!
                notify_players
            rescue StandardError => e
                @display.notifications[:error] = e.message
                retry
            end
        end
        system("clear")
        display.render_board
        #swap turn to get winner
        swap_turn!
        puts "#{current_player} has won! Good Game"
    end

    def notify_players
        if board.in_check?(current_player)
            display.set_check!
        else
            display.uncheck!
        end
    end

    def swap_turn!
        @current_player = current_player == :red ? :blue: :red
    end

    private
    def save_game
        puts "Enter file name to be saved under"
        filename=gets.chomp
        File.write(filename, self.to_yaml)
        exit(0)
    end
end

if $PROGRAM_NAME == __FILE__
    ARGV.count == 0 ? Game.new.play : YAML.load_file(ARGV.shift).play;
end
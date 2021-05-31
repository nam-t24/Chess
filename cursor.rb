require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :cursor_pos, :board
  attr_accessor :toggle_color, :toggle_move_options

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @toggle_color=:light_cyan
    @toggle_move_options=false
  end

  def get_input
    #key is the value in KEYMAP
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    case key
    when :space, :return
      @toggle_color == :light_cyan ? @toggle_color = :light_magenta : @toggle_color = :light_cyan;
      return @cursor_pos
    when :left, :right, :up, :down
      update_pos(key)
      return nil
    when :ctrl_c
      Process.exit(0)
    when :tab
      @toggle_move_options == false ? @toggle_move_options = true : @toggle_move_options = false;
      return nil
    else
      puts key
    end
  end

  def update_pos(diff)
    move_pos = MOVES[diff]
    new_pos = [@cursor_pos[0]+move_pos[0], @cursor_pos[1]+move_pos[1]]
    @cursor_pos = new_pos if @board.valid_pos?(new_pos);
    return nil
  end
end

# testing = Cursor.new([0,0], 0)
# testing.get_input
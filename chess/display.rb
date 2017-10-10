require "colorize"
require_relative "cursor"
require_relative "board"



class Display
  attr_reader :board, :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], @board)
  end

  def render
    system("clear")
    @board.grid.each.with_index do |row, x|
      row.each.with_index do |sqr,y|
        color = {:background => :light_black} if x % 2 == y % 2
        color = {:background => :light_blue} if [x, y] == @cursor.cursor_pos
        color = {:background => :red} if [x, y] == @cursor.selected
        print "#{sqr} ".colorize(color)
      end
      puts ''
    end
    nil
  end
end




b= Board.new
# queen = Queen.new(b,[1,3])
# b.grid[1][3] = queen
bishop = Bishop.new(b,[1,3])
b.grid[1][3] = bishop



display = Display.new(b)
display.render
p Piece::ALL
# p bishop.moves

#
# while true
# display.cursor.get_input
# display.render
# end

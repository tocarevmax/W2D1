require_relative "piece.rb"
# require_relative "display.rb"

class InvalidMove < StandardError
end

class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(8) {Array.new(8) {NullPiece.instance} }
  end

  # def render
  #   @grid.each do |row|
  #     row.each do |sqr|
  #       print "#{sqr}|"
  #     end
  #     puts ''
  #   end
  #   nil
  # end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos,mark)
    x,y = pos
    @grid[x][y] = mark
  end

  def move_piece(start_pos, end_pos)
    obj = self[start_pos]
    raise InvalidMove if obj.is_a?(NullPiece)
    raise InvalidMove if obj.valid_move?(end_pos)
    self[end_pos] = obj
    self[start_pos] = NullPiece.instance
  end

end

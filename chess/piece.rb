require 'singleton'
# require 'board'
require "byebug"

module SlidingPiece
  DIAGONALLY= [[-1,-1], [-1,1], [1,1], [1,-1]]
  HORIZON_VERT= [[0,1], [0,-1], [1, 0], [-1, 0]]


  # which should return an array of places a Piece can move to
  def moves
    possible_moves = []
    move_dirs.each do |dir| #[-1,-1]
      test_pos = @position  #[1,3] - current position
      valid = true
      while valid
        x = dir.first + test_pos.first
        y = dir.last + test_pos.last
        test_pos = [x,y]
        valid = valid_move?([x,y])
        possible_moves << [x,y] if valid
      end
    end
    possible_moves
  end

end

module SteppingPiece

end


class Piece
  attr_reader :board, :position

  ALL = []

  def initialize(board, position)
    @board = board
    @position = position
    ALL << self
  end

  def to_s
    "P"
  end

  def valid_move?(pos)
    in_bounds?(pos) #|| no_piece_blocking?(pos)
  end

  def in_bounds?(pos)
    x,y = pos
    x.between?(0,7) && y.between?(0,7)
  end



end

class Queen < Piece

  # def initialize(board, position)
  #   super
  # end

  include SlidingPiece

  def to_s
    "\ u265B"
  end

  def move_dirs
    DIAGONALLY + HORIZON_VERT
  end

end

class Rook < Piece

  include SlidingPiece

  def to_s
    "R"
  end

  def move_dirs
    HORIZON_VERT
  end

end

class Bishop < Piece

  include SlidingPiece

  def to_s
    "\u265D"
  end

  def move_dirs
    DIAGONALLY
  end

end


class NullPiece < Piece
  include Singleton

  def initialize
  end

  def to_s
    " "
  end

end

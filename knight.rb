require_relative 'stepping_piece'
class Knight < SteppingPiece

  def move_dirs
    [
     [-2, -1],
     [-2,  1],
     [-1, -2],
     [-1,  2],
     [ 1, -2],
     [ 1,  2],
     [ 2, -1],
     [ 2,  1]
    ]
  end

  def to_s
    color == :white ? "\u2658" : "\u265E"
  end
end

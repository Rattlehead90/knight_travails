require_relative 'vertex.rb'

# Board class
class Board
  attr_accessor :board, :unraveling_vertex

  def initialize(width = 8, height = 8)
    @board = []
    width.times do |x|
      height.times do |y|
        @board.append([x, y])
      end
    end

    @knight = [0, 0]
    @relative_moves = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
    @unraveling_vertex = build_graph
  end

  def build_graph(knight = @knight)
    return Vertex.new(@board[0]) if @board.length == 1

    knight_square_vertex = Vertex.new(@board.delete(knight)) if @board.include?(knight)
    absolute_moves = absolute_moves(knight)
    absolute_moves.each do |square|
      square_vertex = Vertex.new(square)
      square_vertex.add_edge(knight)
      knight_square_vertex&.add_edge(square_vertex)
    end
    build_graph(@board.shift)
  end

  def absolute_moves(knight_position)
    absolute_moves = []
    @relative_moves.each do |move_direction|
      x = (move_direction[0] + knight_position[0])
      y = (move_direction[1] + knight_position[1])
      absolute_moves << @board.delete([x, y]) if @board.include?([x, y])
    end
    absolute_moves
  end
end

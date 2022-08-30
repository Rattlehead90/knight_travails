require 'pry-byebug'
require_relative 'vertex'

# Board class
class Board
  attr_accessor :board, :unraveling_vertex, :graph_dict

  def initialize(width = 8, height = 8)
    @board = []
    width.times do |x|
      height.times do |y|
        @board.append([x, y])
      end
    end

    @knight = [0, 0]
    @relative_moves = [[1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
    @graph_dict = {}
    build_graph
  end

  def add_vertex(vertex)
    @graph_dict[vertex.value] = vertex
  end

  def create_or_call(coordinates)
    if @graph_dict.include?(coordinates)
      vertex = @graph_dict[coordinates]
    else
      vertex = Vertex.new(coordinates)
      add_vertex(vertex)
    end
    vertex
  end

  def build_graph(knight = @knight)
    return Vertex.new(@board[0]) if @board.length == 1

    knight_square_vertex = create_or_call(knight)
    absolute_moves = absolute_moves(knight)
    absolute_moves.each do |square|
      square_vertex = create_or_call(square)
      square_vertex.add_edge(knight_square_vertex)
      knight_square_vertex.add_edge(square_vertex)
    end
    build_graph(@board.shift)
  end

  def absolute_moves(knight_position)
    absolute_moves = []
    @relative_moves.each do |move_direction|
      x = (move_direction[0] + knight_position[0])
      y = (move_direction[1] + knight_position[1])
      absolute_moves.append([x, y]) if @board.include?([x, y])
    end
    absolute_moves
  end

  def bfs(start_coordinate, end_coordinate)
    path = [start_coordinate]
    vertex_and_path = [start_coordinate, path]
    bfs_queue = [vertex_and_path]
    visited = []
    while bfs_queue
      current_coordinate, path = bfs_queue.shift
      visited << current_coordinate
      adjacency_list = @graph_dict[current_coordinate].edges
      adjacency_list.each do |neighboring_square|
        next if visited.include?(neighboring_square.value)
        return path + [neighboring_square.value] if neighboring_square.value == end_coordinate

        bfs_queue.append([neighboring_square.value, path + [neighboring_square.value]])
      end
    end
  end

  def shortest_path_between(start, finish)
    path = bfs(start, finish)
    puts "You made it in #{path.length - 1} moves! Here's your path: "
    path.each { |coordinate| puts coordinate.to_s }
  end
end

my_board = Board.new
my_board.shortest_path_between([3, 3], [4, 3])

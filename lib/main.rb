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
    @unraveling_vertex = build_graph
  end

  def add_vertex(vertex)
    @graph_dict[vertex.value] = vertex
  end

  def build_graph(knight = @knight)
    return Vertex.new(@board[0]) if @board.length == 1

    if @graph_dict.include?(knight)
      knight_square_vertex = @graph_dict[knight]
    else
      knight_square_vertex = Vertex.new(knight) 
      add_vertex(knight_square_vertex)
    end
    absolute_moves = absolute_moves(knight)
    absolute_moves.each do |square|
      if @graph_dict.include?(square)
        square_vertex = @graph_dict[square]
      else
        square_vertex = Vertex.new(square)
        add_vertex(square_vertex)
      end
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
      for neighboring_square in @graph_dict[current_coordinate]
        unless visited.include?(neighboring_square)
          if neighboring_square == end_coordinate
            return path + [neighboring_square]
          else
            bfs_queue.append([neighboring_square, path + [neighboring_square]])
          end
        end
      end
    end
  end
end

my_board = Board.new
# my_board.graph_dict[[4, 4]].edges.each { |edge| puts edge.to_s}
# puts (my_board.graph_dict[[4, 4]].edges.each { |edge| puts edge.value.to_s })
# puts my_board.graph_dict[[4, 4]].edges.to_s
vertex = my_board.graph_dict[[3, 2]]
lst_edges = vertex.edges
lst_edges.each { |vertex| puts vertex.value.to_s }

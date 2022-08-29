# Vertex helper class
class Vertex
  attr_accessor :value, :edges

  def initialize(value)
    @value = value
    @edges = []
  end

  def add_edge(vertex)
    @edges << vertex
  end
end

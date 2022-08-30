# knight_travails
TOP project elaborating on data structures. The goal is to make a function knight_moves that shows the shortest possible way to get from one square to another by outputting all squares the knight will stop on along the way.

# Pseudocode 

# 1. iteration
  mapping mechanism: absolute possible moves = relative possible moves + knight's position

  to create a DAG (directed acyclic graph) of the board: 
    - assume a starting position (e.g. [0, 0])
    - proceed with generating all absolute possible moves from the starting position (using relative possible moves of the knight)
      -- check against board coordinates (new absolute positions should be on the board, i.e. contained in board coordinates array)
      -- board squares are vertices with respective coordinates and multiple children
      -- whenever the board coordinate is visited it gets shifted out of the coordinates given
    - move your starting position to the first of the generated absolute possible moves and repeat the process (recursion)
    - base case: if there is no more absolute possible moves from the current position, return none??

  we have a board-DA-graph (border-graph for the locals), proceed to BFS while saving visited vertices 
# 2. iteration
  to create a DG (directed graph) of the board:
    - assume a starting position
    - create a list of chessboard squares coordinates
    - proceed with generating all absolute possible moves from the starting position (using relative possible moves of the knight)
      -- pop chessboard squares off of board coordinates list and make their coordinates values for vertices (that are connected with the starting position)

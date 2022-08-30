# knight_travails
TOP project elaborating on data structures. The goal is to make a function knight_moves that shows the shortest possible way to get from one square to another by outputting all squares the knight will stop on along the way.

# Gist
The goal was to create an algorithm for finding the shortest path a knight might take on a chess board between two points. You can change the start and end coordinates passed in the shortest_path_between() to see how it works. The chessboard is emulated by assigning coordinates to the tiles: the A1 is [0, 0] and H8 is [7, 7] (rather unfortunate, but timely sacrifice to the good old symmetry).

# Approach
I've created a Board class which performs the meta-vertexal function of keeping a @graph_dict(ionary), i.e. assigning a string representation of the value as a label for the created vertex. It also holds all on-board coordinates and all possible knight's moves in arrays. (Relative moves are represented as a 'movement vector' as it's components should be added to a particular knight's position to get an absolute move, simply coordinates.) The tiles are made into vertices connected by knight's move pattern. The shortest path is then found using BFS (breadth first search).

# What have I learned
I will be honest, it did not go as smooth as I've expected. I took my time and dived in theory background to find my bearing: graphs, graph searches. After that it was a matter of figuring out how to properly project the knowledge unto the chessboard. 
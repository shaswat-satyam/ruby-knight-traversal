include Comparable

def display(x,y)
  board = Array.new(8) { Array.new(8){0}}
  board[x][y] = '♞'
  moves = possible_moves(x,y)
  moves.each do |move|
    board[move.x][move.y] = "⬤" unless move.nil?
  end
  board.each do |row|
    row.each do |cell|
      print "#{cell} "
    end
    puts
  end
  puts 
end

class Move
  attr_accessor :x, :y
  
  def initialize(posx, posy)
      @x = posx
      @y = posy
  end
  def ==(other_move)
   x == other_move.x && other_move.y == y
 end
end

$knight_moves = [Move.new(2, 1), Move.new(1, 2), Move.new(-1, 2), Move.new(-2, 1),Move.new(-2, -1), Move.new(-1, -2), Move.new(1,-2), Move.new(2, -1)]

def possible_moves(posx, posy)
  moves = [nil] * 8
  for i in (0..7)
    p = posx+$knight_moves[i].x 
    q = posy+$knight_moves[i].y 
    
    if((p >= 0 and q >= 0) and (p < 8 and q < 8))
      moves[i] = (Move.new(p,q))
    end
  end
  moves
end
moves_x = [2, 1, -1, -2, -2, -1,  1,  2]
moves_y = [1, 2,  2,  1, -1, -2, -2, -1]



class Node
  attr_accessor :data, :uur, :urr, :drr, :ddr, :ddl, :dll, :ull,:uul
  def initialize(move,queue)
    if move.nil?
      return self
    elsif queue.any?{|i| i == move}
      return self
    else
      queue.push move
      next_moves = possible_moves(move.x, move.y)
      @data = move

      @ddr = Node.new(next_moves[0],queue) unless next_moves[0].nil?
      @drr = Node.new(next_moves[1],queue) unless next_moves[1].nil?
      @urr = Node.new(next_moves[2],queue) unless next_moves[2].nil?
      @uur = Node.new(next_moves[3],queue) unless next_moves[3].nil?
      @uul = Node.new(next_moves[4],queue) unless next_moves[4].nil?
      @ull = Node.new(next_moves[5],queue) unless next_moves[5].nil?
      @dll = Node.new(next_moves[6],queue) unless next_moves[6].nil?
      @ddl = Node.new(next_moves[7],queue) unless next_moves[7].nil?
    end
  end
end

class Tree
  attr_accessor :root

  def initialize(x, y)
    move = Move.new(x, y)
    queue = []
    @root = Node.new(move, queue)
  end

  def traversal(node = root)
    if node.nil?
      return nil
    elsif node.data.nil?
      return nil
    end
    print " #{node.data.x}#{node.data.y} "
    traversal node.uur #unless node.uur.nil? 
    traversal node.urr #unless node.urr.nil?
    traversal node.drr #unless node.drr.nil?
    traversal node.ddr #unless node.ddr.nil?
    traversal node.ddl #unless node.ddl.nil?
    traversal node.dll #unless node.dll.nil?
    traversal node.ull #unless node.ull.nil?
    traversal node.uul #unless node.uul.nil?
  end

  def find(node, curr = root)
    if curr.nil?
      return nil
    elsif curr.data.nil?
      return nil
    else node == curr.data
      return self
    end
    print " #{node.data.x}#{node.data.y} "
    find(node, node.uur) unless node.uur.nil? 
    find(node, node.urr) unless node.urr.nil?
    find(node, node.drr) unless node.drr.nil?
    find(node, node.ddr) unless node.ddr.nil?
    find(node, node.ddl) unless node.ddl.nil?
    find(node, node.dll) unless node.dll.nil?
    find(node, node.ull) unless node.ull.nil?
    find(node, node.uul) unless node.uul.nil?
  end

  def height_node(node)
    if node.nil?
      return 0
    elsif node
    else
      h_arr = [0]
      h_arr.push height_node(node.uur) unless node.uur.nil?
      h_arr.push height_node(node.urr) unless node.urr.nil?
      h_arr.push height_node(node.drr) unless node.drr.nil?
      h_arr.push height_node(node.ddr) unless node.ddr.nil?
      h_arr.push height_node(node.ddl) unless node.ddl.nil?
      h_arr.push height_node(node.dll) unless node.dll.nil?
      h_arr.push height_node(node.ull) unless node.ull.nil?
      h_arr.push height_node(node.uul) unless node.uul.nil?
      return h_arr.max + 1
    end
  end

  def height
    height_node(root)
  end

  def levelOrder(root = @root)
    queue = []
    result = []
    node = root
    until node.nil?
      result.push [node.data.x,node.data.y] unless node.data.nil?
      queue.push node.uur unless node.uur.nil? 
      queue.push node.urr unless node.urr.nil?
      queue.push node.drr unless node.drr.nil?
      queue.push node.ddr unless node.ddr.nil?
      queue.push node.ddl unless node.ddl.nil?
      queue.push node.dll unless node.dll.nil?
      queue.push node.ull unless node.ull.nil?
      queue.push node.uul unless node.uul.nil?
      node = queue.shift
    end
    result
  end
end


def knight_moves(start,final)
  t1 = Tree.new(start[0],start[1])
  traversal = t1.levelOrder
  count = 0
  curr = traversal[0]
  until curr == final
    display(curr[0],curr[1])
    count += 1
    curr = traversal[count]
  end
  display(curr[0],curr[1])
  puts "You made it in #{t1.height - t1.height_node(t1.find(Move.new(final[0], final[1])))} moves!"
end

def play
  puts 'Enter the position'
  x = gets.chomp.to_i
  y = gets.chomp.to_i
  display(x,y)
  while true
    puts 'Enter the new position'
    next_moves = possible_moves(x,y)
    p next_moves
    x = gets.chomp.to_i
    y = gets.chomp.to_i
    if next_moves.any?{|move| move == Move.new(x,y)}
      display(x,y)
    else
      puts 'Invalid Move'
    end
  end
end


knight_moves([1,1],[1,2])

@board = Array.new(8){Array.new(8)}
@path = []
class Node
  attr_accessor :pos, :ul, :ur,:lu,:ld,:dl,:dr,:rd,:ru
  @pos = Array.new(2)
  def initialize(pos)
    @pos = pos
  @ul = nil
  @ur = nil
  @lu = nil
  @ld = nil
  @dl = nil
  @dr = nil
  @rd = nil
  @ru = nil
  end 
end


def validMove?(move)
  move[0].between?(0,7) and move[1].between?(0,7) and @board[move[0]][move[1]].nil?
end

# @queue = []
@q = []

def setNeigbours(root)
   start = root.pos 
#upper left move
  posMove = [start[0]-2,start[1]-1]
   
  if validMove?(posMove)
    root.ul = Node.new(posMove)
    @q.append(root.ul)
    @board[posMove[0]][posMove[1]] = 1
  end
#upper right move
  posMove = [start[0]-2,start[1]+1]
  if validMove?(posMove)
    root.ur = Node.new(posMove)
    @q.append(root.ur)
    @board[posMove[0]][posMove[1]] = 1
  end
 #left upper move 
  posMove = [start[0]-1,start[1]+2]
  if validMove?(posMove)
    root.lu =  Node.new(posMove)
    @q.append(root.lu)
    @board[posMove[0]][posMove[1]] = 1
  end
#left down move
  posMove = [start[0]+1,start[1]+2]
  if validMove?(posMove)
    root.ld =  Node.new(posMove)
    @q.append(root.ld)
    @board[posMove[0]][posMove[1]] = 1
  end
 # down Left move 
  posMove = [start[0]+2,start[1]-1]
  if validMove?(posMove)
    root.dl = Node.new(posMove)
    @q.append(root.dl)
    @board[posMove[0]][posMove[1]] = 1
  end   

# down right move
  
  posMove = [start[0]+2,start[1]+1]
  if validMove?(posMove)
    root.dr =  Node.new(posMove)
    @q.append(root.dr)
    @board[posMove[0]][posMove[1]] = 1
  end   
# right down move
  posMove = [start[0]+1,start[1]-2]
  if validMove?(posMove)
    root.rd = Node.new(posMove)
    @q.append(root.rd)
    @board[posMove[0]][posMove[1]] = 1
  end   
# right up move 
  posMove = [start[0]-1,start[1]-2]
  if validMove?(posMove)
    root.dl = Node.new(posMove)
    @q.append(root.dl)
    @board[posMove[0]][posMove[1]] = 1
  end   
end


def createTree(start)
  root =  Node.new(start)
  setNeigbours(root)
  @q.append(root) 
  while @q.length != 0
      temp = @q.shift 
      setNeigbours(temp)
      @q.compact!
  end
  root
end

def inorder(root)
  if root.nil?
    return;
  end
  print(root.pos)
  inorder(root.ul)
  inorder(root.ur)
  inorder(root.lu)
  inorder(root.ld)
  inorder(root.dl)
  inorder(root.dr)
  inorder(root.rd)
  inorder(root.ru)
end


def traversal(start,finish)
  root = createTree(start)
  # inorder(root)
  # @queue = [root]
  # while @queue.length != 0
  #   temp = @queue.shift
  #    
  #   @queue.append(temp.ul)
  #   @queue.append(temp.ur)
  #   @queue.append(temp.lu)
  #   @queue.append(temp.ld)
  #   @queue.append(temp.dl)
  #   @queue.append(temp.dr)
  #   @queue.append(temp.rd)
  #   @queue.append(temp.ru)
  #   @queue.compact!
  #   if(@queue.any?{|move| move.nil? == false and move.pos == finish})
  #     @queue.each{|move| p move.pos}
  #     break
  #   end
  # end
  
  dfs(root,finish)
end

def dfs(root,key)
  if root.nil?
    return false
  end
  if root.pos == key
    @path << root.pos
    return true
  end
  ul = dfs(root.ul,key)
  ur = dfs(root.ur,key)
  lu = dfs(root.lu, key)
  ld = dfs(root.ld,key)
  dl = dfs(root.dl,key)
  dr = dfs(root.dr,key)
  rd = dfs(root.rd,key)
  ru = dfs(root.ru,key)
  if ul or ur or lu or ld or dl or dr or rd or ru
    @path << root.pos
    return true
  end
  return false
end
def display(path)
  8.times do |i|
    8.times{|k| print"--"}
    puts ''
    8.times do |j|
      print '|'
      if path.any?{|move| move[0] == i and move[1] == j}
        print "x"
      else 
        print " "
      end
      if j == 7
       print "|"
      end
    end
    puts ""
  end
  8.times{|k| print"--"}
end
start = [rand(0..7),rand(0..7)]
finish = [rand(0..7),rand(0..7)]
traversal(start,finish)
print @path.reverse 
puts ""
@path.reverse.each{|move| p move}
display(@path.reverse)

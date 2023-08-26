def display(x,y)
  board = Array.new(8) { Array.new(8){0}}
  board[x][y] = '♞'
  board.each do |row|
    row.each do |cell|
      print "#{cell} "
    end
    puts
  end
end

display(1, 1)

DATA = File.read('data.txt')
    .strip
    .split(",")
    .map(&:to_sym)

DIRECTIONS = {
    n:  [ 0,  1, -1],
    ne: [ 1,  0, -1],
    se: [ 1, -1,  0],
    s:  [ 0, -1,  1],
    sw: [-1,  0,  1],
    nw: [-1,  1,  0],
}

DISTANCES = DATA
    .inject([[0,0,0]]){ |l, dir| l.push DIRECTIONS[dir].zip(l.last).map(&:sum) }
    .map{ |arr| arr.map(&:abs).sum / 2 }

P1, P2 = DISTANCES.last, DISTANCES.max

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

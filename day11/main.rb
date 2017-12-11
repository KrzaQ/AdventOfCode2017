require 'set'

# DATA = 'ne,ne,ne'
DATA = File.read('data.txt')
    .strip
    .split(",")
    .map(&:to_sym)

def coord_offset(direction, from)
    case direction
    when :se
        from.first % 2 == 0 ?  [1, 0] : [1, 1]
    when :s
        [0, 1]
    when :sw
        from.first % 2 == 0 ?  [-1, 0] : [-1, 1]
    when :nw
        from.first % 2 == 0 ?  [-1, -1] : [-1, 0]
    when :n
        [0, -1]
    when :ne
        from.first % 2 == 0 ?  [1, -1] : [1, 0]
    end
end

def move_coord(direction, from)
    coord_offset(direction, from).zip(from).map(&:sum)
end

FINAL_LOCATION = DATA.inject({current: [0, 0], past: []}){ |pos, dir| {current: move_coord(dir, pos[:current]), past: pos[:past] + [pos[:current]] } }

def find_distances
    distances = { [0, 0] => 0 }
    directions = [:se, :s, :sw, :nw, :n, :ne]
    todo = [
        [0, 0]
    ]

    final = 0
    max_dist = 0

    visited = FINAL_LOCATION[:past].to_set
    visited.add FINAL_LOCATION[:current]
    visited.delete [0, 0]

    loop do
        added = []
        todo.each do |coord|
            directions.each do |dir|
                new_coord = move_coord(dir, coord)
                
                next if distances.has_key? new_coord

                distances[new_coord] = distances[coord] + 1

                added.push new_coord

                if visited.include? new_coord
                    max_dist = [max_dist, distances[new_coord]].max
                    visited.delete new_coord
                end

                if visited.size == 0
                    return [distances[FINAL_LOCATION[:current]], max_dist]
                end
            end
        end
        todo = added.clone
    end
end

P1, P2 = find_distances

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

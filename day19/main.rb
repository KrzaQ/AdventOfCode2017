DATA = File.read('data.txt').split("\n")

def get_xy(x, y)
    return ' ' if x >= DATA.first.size
    return ' ' if x < 0
    return ' ' if y >= DATA.size
    return ' ' if y < 0
    DATA[y][x]
end

def move_dir(x, y, direction)
    {
        up: [x, y-1],
        down: [x, y+1],
        left: [x-1, y],
        right: [x+1, y],
    }[direction]
end

def solve
    idx = DATA.first.index '|'
    direction = :down
    letters = []
    x, y = idx, 0
    steps = 0
    loop do
        steps += 1
        x, y = move_dir x, y, direction
        case get_xy(x, y)
        when '+'
            direction = {
                up: [:left, :right],
                down: [:left, :right],
                left: [:up, :down],
                right: [:up, :down],
            }[direction].select{ |d| get_xy(*move_dir(x, y, d)) =~ /\||\-|\w/ }.first
        when /\||\-/
            next
        when ' '
            break
        else
            letters.push get_xy(x, y)
        end
    end
    [letters.join, steps]
end

P1, P2 = solve

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

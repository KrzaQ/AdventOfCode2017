DATA = File.read('data.txt').split.map(&:to_i)

def solve(data, &blk)
    i = 0
    count = 0
    while i < data.size and i >= 0
        offset = data[i]
        data[i] = blk.call data[i]
        i = i + offset
        count += 1
    end
    count
end

P1 = solve(DATA.clone){ |n| n + 1 }
P2 = solve(DATA.clone){ |n| n + (n > 2 ? -1 : 1) }

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

require 'set'

DATA = File.read('data.txt').split.map(&:to_i)

def do_cycle(cache, data)
    cache.add data.join('.')
    idx = data.find_index data.max
    m = data[idx]
    data[idx] = 0
    ((idx+1)..(idx+m)).each{ |i| data[i%data.size] += 1 }
end

def try_cycles(data)
    data = data.clone
    cache = Set.new

    # PART 1
    p1count = 0
    while not cache.include? data.join('.')
        do_cycle cache, data
        p1count += 1
    end

    # PART 2
    sought = data.join('.')
    p2count = 0
    loop do
        do_cycle cache, data
        p2count += 1
        break if sought == data.join('.')
    end

    [p1count, p2count]
end

P1, P2 =  try_cycles DATA

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

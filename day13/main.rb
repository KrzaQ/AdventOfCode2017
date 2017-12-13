DATA = File.read('data.txt')
    .each_line
    .map(&:strip)
    .map{ |line| line.split(': ').map(&:to_i) }
    .to_h

def count_catch_severity(delay, bail_early = false)
    DATA.inject([0, false]) do |state, el|
        index, depth = el
        count, caught = state
        if (index+delay) % (2*(depth-1)) == 0
            count += index * depth
            caught = true
            return [ -1, true ] if bail_early
        end
        [ count, caught ]
    end
end

P1 = count_catch_severity(0).first
P2 = (0..Float::INFINITY)
    .find{ |n| count_catch_severity(n, true).last == false }

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

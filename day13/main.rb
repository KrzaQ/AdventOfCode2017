require 'set'

DATA = File.read('data.txt')
    .each_line
    .map(&:strip)
    .map{ |line| line.split(': ').map(&:to_i) }
    .to_h

def count_catch_severity(delay)
    DATA.inject(0) do |c, el|
        index, depth = el
        if (index+delay) % (2*(depth-1)) == 0
            c += index * depth
        end
        c
    end
end

P1 = count_catch_severity 0
P2 = (0..Float::INFINITY)
    .lazy
    .reject{ |n| DATA.fetch(0, 0) > 0 ? n % (2*(DATA[0]-1)) == 0 : false }
    .find{ |n| count_catch_severity(n) == 0 }

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

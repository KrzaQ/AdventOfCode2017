DATA = File.read('data.txt')
    .each_line
    .map(&:strip)
    .map{ |line| line.split(': ').map(&:to_i) }
    .to_h

def period_of(n)
    2 * (n - 1)
end

P1 = DATA
    .select{ |k, v| k % period_of(v) == 0 }
    .map{ |k, v| k * v }
    .sum

P2 = (1..Float::INFINITY)
    .find{ |n| DATA.all?{ |k, v| (k+n) % period_of(v) > 0 } }

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

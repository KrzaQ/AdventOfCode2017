DATA = File.read('data.txt')
    .each_line
    .map{ |s| s.split.map(&:to_i) }


P1 = DATA
    .map{ |arr| arr.minmax.reverse.inject(:-) }
    .sum

def get_div(arr)
    result = arr
        .combination(2)
        .map(&:sort)
        .map(&:reverse)
        .find{ |k, v| k % v == 0 }
    result.first / result.last
end

P2 = DATA
    .map{ |a| get_div a }
    .sum

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

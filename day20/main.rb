DATA = File.read('data.txt')
    .scan(/p=<(-?\d+),(-?\d+),(-?\d+)>, v=<(-?\d+),(-?\d+),(-?\d+)>, a=<(-?\d+),(-?\d+),(-?\d+)>/)
    .map{ |a| a.map(&:to_i) }

P1 = DATA
    .each_with_index
    .map{ |a, i| [a.each_slice(3).map{ |n| n.map(&:abs).sum }, i] }
    .sort_by{ |a, i| a.reverse }
    .first
    .last

def solve_p2
    parts = DATA
        .each_with_index
        .map { |a, i| [i, { pos: a[0...3], vel: a[3...6], acc: a[6...9], id: i }] }
        .to_h

    count = 0
    loop do
        count += 1

        parts
            .values
            .group_by{ |h| h[:pos] }
            .select{ |k, v| v.size > 1 }
            .each do |k, v|
                v.each do |el|
                    parts.delete el[:id]
                end
            end

        parts = parts
            .values
            .map{ |h| h.merge({vel: h[:vel].zip(h[:acc]).map(&:sum), pos: h[:pos].zip(h[:vel],h[:acc]).map(&:sum)}) }
            .map{ |h| [h[:id], h] }
            .to_h

        break if count > 1_000
    end
    parts.size
end

P2 = solve_p2

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

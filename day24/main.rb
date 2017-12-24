DATA = File.read('data.txt')
    .scan(/(\d+)\/(\d+)/)
    .map{ |a| a.map(&:to_i) }

def combinations(data, arr = [0])
    r = data
        .select{ |a| a.include? arr.last }
        .map { |a| a.first == arr.last ? a : a.reverse }
        .map do |a|
            k, n = a
            deeper = arr + [n]
            new_data = data
                .reject{ |o| a.sort == o.sort }
            combinations(new_data, deeper)
    end
    r.size > 0 ? r.flatten(1) : [arr]
end

def strength arr
    arr
        .each_cons(2)
        .inject(0){ |t, el| t + el.first + el.last }
end

COMBINATIONS = combinations(DATA).map{ |a| [a, strength(a)] }

P1 = COMBINATIONS
    .map(&:last)
    .max

P2 = COMBINATIONS
    .sort{ |l, r| [l.first.size, l.last] <=> [r.first.size, r.last] }
    .last
    .last

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

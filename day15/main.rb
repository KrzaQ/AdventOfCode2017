A = [512, 16807]
B = [191, 48271]


def make_generator(start, multiplier, multiples_of = 1)
    Enumerator.new do |enum|
        value = start
        while true
            value = value * multiplier % 2147483647
            enum.yield value & 0xFFFF if value % multiples_of == 0
        end
    end
end


P1 = make_generator(*A)
    .lazy
    .take(40_000_000)
    .zip(make_generator(*B))
    .count{ |l, r| l == r }


P2 = make_generator(*A, 4)
    .lazy
    .take(5_000_000)
    .zip(make_generator(*B, 8))
    .count{ |l, r| l == r }


puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

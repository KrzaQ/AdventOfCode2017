DATA = 324

class Object
    def yield_self
        yield self
    end
end

P1 = (1..2017).inject([[0], 0]) do |s, n|
    t, pos = s
    pos = 1+(pos+DATA) % n
    t.insert(pos, n)
    [t, pos]
end.yield_self{ |o| o.first[o.first.index(2017)+1] }

P2 = (1..50_000_000).inject([0, 0]) do |s, n|
    val, pos = s
    pos = 1+(pos+DATA) % n
    val = n if pos == 1
    [val, pos]
end.first

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

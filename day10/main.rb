DATA = '197,97,204,108,1,29,5,71,0,50,2,255,248,78,254,63'

KNOTS = 256

def do_round(data, el)
    knots, pos = data
    len, skip = el
    rng = (pos...(pos+len))
    knots = knots[0...KNOTS] * 2
    knots[rng] = knots[rng].reverse
    
    knots[0...pos] = knots[KNOTS...(KNOTS+pos)] if pos > 0 

    pos += skip + len
    pos %= KNOTS

    [knots, pos]
end

P1 = DATA
    .split(',')
    .map(&:to_i)
    .each_with_index
    .inject([(0...KNOTS).to_a * 2, 0]) { |data, el| do_round data, el }
    .first
    .take(2)
    .inject(:*)

P2 = (DATA
    .each_codepoint
    .to_a
    .insert(-1, 17, 31, 73, 47, 23) * 64)
    .each_with_index
    .inject([(0...KNOTS).to_a * 2, 0]) { |data, el| do_round data, el }
    .first
    .take(KNOTS)
    .each_slice(16)
    .map{ |s| s.inject(:^).to_s(16) }
    .map{ |s| s.size < 2 ? '0%s' % s : s }
    .join

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

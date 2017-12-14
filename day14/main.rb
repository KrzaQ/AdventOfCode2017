DATA = 'vbqugkhl-%d'
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

class Object
    def yield_self
        yield self
    end
end

def knot_hash(str)
    str
        .each_codepoint
        .to_a
        .insert(-1, 17, 31, 73, 47, 23)
        .yield_self{ |a| a * 64 }
        .each_with_index
        .inject([(0...KNOTS).to_a * 2, 0]) { |data, el| do_round data, el }
        .first
        .take(KNOTS)
        .each_slice(16)
        .map{ |s| '%02x' % s.inject(:^) }
        .join
end

HASHED = (0...128).map{ |n| knot_hash(DATA % n) }

P1 = HASHED
    .map{ |hash| hash.to_i(16).to_s(2).count('1') }
    .sum

def get_xy(str_arr, x, y)
    return 0 if y < 0
    return 0 if y >= str_arr.size
    return 0 if x < 0
    return 0 if x >= str_arr[0].size
    str_arr[y][x]
end

def mark_group(str_arr, x, y, number)
    str_arr[y][x] = number
    mark_group(str_arr, x-1, y  , number) if get_xy(str_arr, x-1, y  ) == 1
    mark_group(str_arr, x  , y+1, number) if get_xy(str_arr, x  , y+1) == 1
    mark_group(str_arr, x+1, y  , number) if get_xy(str_arr, x+1, y  ) == 1
    mark_group(str_arr, x  , y-1, number) if get_xy(str_arr, x  , y-1) == 1
end

def count_groups(str_arr)
    group_count = 0
    (0..127).each do |y|
        (0..127).each do |x|
            if get_xy(str_arr, x, y) == 1
                mark_group(str_arr, x, y, group_count+2)
                group_count += 1
            end
        end
    end
    group_count
end

P2 = count_groups(
        HASHED
        .map{ |h| h.to_i(16).to_s(2).split('').map(&:to_i) }
    )

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

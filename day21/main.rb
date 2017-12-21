class Object
    def yield_self
        yield self
    end
end

def combinations(a)
    [
        a,
        a.reverse,
        a.map(&:reverse),
        a.reverse.map(&:reverse),
        a.map(&:each_char).map(&:to_a).transpose.map(&:join),
        a.map(&:each_char).map(&:to_a).transpose.map(&:join).map(&:reverse),
        a.map(&:each_char).map(&:to_a).transpose.map(&:join).reverse,
        a.map(&:each_char).map(&:to_a).transpose.map(&:join).reverse.map(&:reverse),
    ].uniq
end

DATA = File.read('data.txt')
    .scan(/(...?\/...?(?:\/...)?) => (....?\/....?\/....?(?:\/....)?)/)
    .map{ |k, v| combinations(k.split('/')).map{ |c| [c.join('/'), v.split('/')] } }
    .flatten(1)
    .to_h

def enhance(img)
    square_size = img.size % 2 == 0 ? 2 : 3
    (0...img.size/square_size)
        .yield_self{ |n| n.to_a * n.size }
        .yield_self{ |n| n.zip(n.sort) }
        .map do |x, y|
            (x*square_size...(x+1)*square_size).map do |x1|
                (y*square_size...(y+1)*square_size).map{ |y1| img[y1][x1] }.join
            end.join('/')
        end
        .map{ |s| DATA[s] }
        .each_slice(img.size/square_size)
        .map{ |a| (0..square_size).map{ |n| a.map{ |el| el[n] }.join } }
        .flatten(1)
end

def solve
    img = ['.#.', '..#', '###']
    p1 = (1..5)
        .inject(img){ |img, _| enhance img }
        .join
        .count('#')
    p2 = (1..18)
        .inject(img){ |img, _| enhance img }
        .join
        .count('#')
        [p1, p2]
end

P1, P2 = solve

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2


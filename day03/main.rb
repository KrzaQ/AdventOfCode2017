
P1DATA = 347991
P1NEXT_BASE = Math.sqrt(P1DATA).ceil
P1NEXT_SQUARE = P1NEXT_BASE**2

P1DIFF = P1NEXT_SQUARE - P1DATA
 
P1 =  P1NEXT_BASE/2 + P1NEXT_BASE/2-1 - 109


def get_sum(h,x,y)
    r = h.fetch(x-1,{}).fetch(y-1,0) + 
        h.fetch(x  ,{}).fetch(y-1,0) + 
        h.fetch(x+1,{}).fetch(y-1,0) + 
        h.fetch(x-1,{}).fetch(y  ,0) + 
        h.fetch(x+1,{}).fetch(y  ,0) + 
        h.fetch(x-1,{}).fetch(y+1,0) + 
        h.fetch(x  ,{}).fetch(y+1,0) + 
        h.fetch(x+1,{}).fetch(y+1,0)

    raise r.to_s if r > P1DATA
    r
end

def build_hash(n)
    h = { 0 => { 0 => 1 } }
    x, y = 0, 0

    (1..n).step(2).each do |iter|
        (1..iter).each do |v|
            x += 1
            tmp = h.fetch(x, {})
            tmp[y] = get_sum(h,x,y)
            h[x] = tmp
        end
        (1..iter).each do |v|
            y += 1
            tmp = h.fetch(x, {})
            tmp[y] = get_sum(h,x,y)
            h[x] = tmp
        end
        (1..(iter+1)).each do |v|
            x -= 1
            tmp = h.fetch(x, {})
            tmp[y] = get_sum(h,x,y)
            h[x] = tmp
        end
        (1..(iter+1)).each do |v|
            y -= 1
            tmp = h.fetch(x, {})
            tmp[y] = get_sum(h,x,y)
            h[x] = tmp
        end
    end
    h
end

begin
    build_hash(50)
rescue => result
    P2 = result
end


puts "Part 1: %s" % P1
puts "Part 2: %s" % P2


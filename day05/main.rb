P1DATA = File.read('data.txt').split.map(&:to_i)
P2DATA = P1DATA.clone

i = 0
count = 0
while i < P1DATA.size and i >= 0
    offset = P1DATA[i]
    P1DATA[i] += 1
    i = i + offset
    count += 1
end

P1 = count


i = 0
count = 0
while i < P2DATA.size and i >= 0
    offset = P2DATA[i]
    if offset < 3
        P2DATA[i] += 1
    else
        P2DATA[i] -= 1
    end
    i = i + offset
    count += 1
end

P2 = count

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

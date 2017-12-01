data = File.read('data.txt')
    .each_codepoint
    .map(&:chr)
    .select{ |c| c =~ /\d/ }
    .map(&:to_i)

MAX_LEN = data.size

(0...MAX_LEN).each do
    break unless data.first == data.last
    data.rotate!
end

PART1 = data
    .map(&:to_s)
    .join
    .scan(/(\d)(\1+)/)
    .map{ |digit, repeats| digit.to_i * repeats.size }
    .sum


p2sum = 0
(0...MAX_LEN).each do |i|
    p2sum += data[i].to_i if data[i] == data[(i+MAX_LEN/2)%MAX_LEN]
end

puts "Part 1: %s" % PART1
puts "Part 2: %s" % p2sum

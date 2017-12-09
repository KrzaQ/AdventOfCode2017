data = File.read('data.txt')

while data.gsub!("!!", '') do end

garbage = 0
data.gsub!(/(?:<>|<.*?[^!]>)/){ |match|
    if match.length > 2
        filtered = match.gsub(/!./, '')
        garbage += filtered.length - 2
    end
    ''
}

data.gsub!(',', '')

score = 0
depth = 0
data.each_codepoint.each do |c|
    case c.chr
    when '{'
        depth += 1
        score += depth
        next
    when '}'
        depth -= 1
        next
    end
end

P1, P2 = score, garbage

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

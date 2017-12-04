require 'set'

DATA = File.read('data.txt').each_line.map(&:split)


P1 = DATA.map{ |l| l.to_set.size == l.size }.count(true)
P2 = DATA.map{ |l| l.map(&:each_codepoint).map(&:sort).to_set.size == l.size }.count(true)


puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

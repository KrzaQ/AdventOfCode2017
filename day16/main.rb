require 'set'

DATA = File.read('data.txt')
    .split(',')
    .map{ |step| step.scan(/(\w)([a-z0-9][a-z0-9]?)\/?(..?)?/).first }

def range; ('a'..'p').to_a; end

def perform_step(dancers, step)
    type = step.first.to_sym
    elem = step[1]
    extra = step.last
    case type
    when :s
        dancers.rotate -elem.to_i
    when :x
        dancers[elem.to_i], dancers[extra.to_i] = dancers[extra.to_i], dancers[elem.to_i]
        dancers
    when :p
        i1, i2 = dancers.index(elem), dancers.index(extra)
        dancers[i1], dancers[i2] = dancers[i2], dancers[i1]
        dancers
    end
end

def dance(elems)
    DATA.inject(elems){ |t, step| perform_step t, step }
end

P1 = dance(range).join

def solve_part2
    arr = range
    s = [arr].to_set
    loop do
        arr = dance arr
        if not s.add? arr
            break
        end
    end

    index = 1_000_000_000 % s.size
    (1..index).inject(range) { |r, _| dance r }.join
end

P2 = solve_part2

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

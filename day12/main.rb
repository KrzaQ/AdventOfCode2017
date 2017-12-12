require 'set'

DATA = File.read('data.txt')
    .each_line
    .map(&:strip)
    .map{ |line| line.split(' <-> ') }
    .map{ |id, connected| [id.to_i, connected.split(', ').map(&:to_i)] }
    .to_h


def connected_to_n(n)
    to_check = DATA[n].to_set
    connected = [n].to_set
    while to_check.size > 0
        el = to_check.first
        to_check.delete el
        next if connected.include? el
        to_check |= DATA[el].to_set
        connected.add el
    end
    connected
end

def groups
    nodes = DATA.keys.to_set
    count = 0
    while nodes.size > 0
        grp = connected_to_n(nodes.first)
        nodes.subtract grp
        count += 1
    end
    count
end

P1 = connected_to_n(0).size
P2 = groups
puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

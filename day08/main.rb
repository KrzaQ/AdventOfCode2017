DATA = File.read('data.txt')
    .each_line
    .map{ |l| l.scan(/(\w+) (inc|dec) (-?\d+) if (.+)/) }

class Registers

    def initialize
        @registers = {}
    end

    def [](reg)
        @registers.fetch(reg, 0)
    end

    def []=(reg, val)
        @registers[reg] = val
    end

    def method_missing(name)
        self[name[4..-1]]
    end

    def get_max
        @registers.values.max
    end
end

$registers = Registers.new

total_max = 0

DATA.each do |a|
    reg, action, num, condition = a[0]

    num = num.to_i
    num *= -1 if action == 'dec'

    if eval('$registers.reg_' + condition)
        $registers[reg] = $registers[reg] + num
        total_max = [total_max, $registers.get_max].max
    end
end

P1, P2 = [$registers.get_max, total_max]


puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

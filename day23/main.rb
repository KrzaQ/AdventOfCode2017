DATA = File.read('data.txt')
    .split("\n")
    .map{ |l| l.split.map{ |e| e =~ /[a-z]+/ ? e.to_sym : e.to_i } }

class Program

    def initialize code
        @code = code
        @current_instruction = 0
        @data = {}
        @mul_count = 0
    end

    def exec_instruction instruction
        self.send(*instruction)
    end

    def execute
        while @current_instruction < @code.size do
            exec_instruction @code[@current_instruction][0...3]
            @current_instruction += 1
        end
    end

    def set b, c
        @data[b] = val(c)
    end

    def sub b, c
        @data[b] = val(b) - val(c)
    end

    def mul b, c
        @mul_count += 1
        @data[b] = val(b) * val(c)
    end

    def mod b, c
        @data[b] = val(b) % val(c)
    end

    def jnz b, c
        @current_instruction += val(c) - 1 if val(b) != 0
    end

    def val x
        case x
        when Symbol
            @data.fetch(x, 0)
        else
            x
        end
    end

    def mul_count
        @mul_count
    end
end

class Object
    def yield_self
        yield self
    end
end

P1 = Program.new(DATA)
    .yield_self{ |p| p.execute; p }
    .mul_count

P2 = (0..1000).map do |n|
    b = DATA.first.last * 100 + 100_000 + n * 17
    not_prime = (2..Math.sqrt(b).floor)
                .lazy
                .any?{ |m| b % m == 0 }
    not_prime ? 1 : 0
end.sum

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

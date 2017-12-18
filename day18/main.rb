DATA = File.read('data.txt')
    .split("\n")
    .map{ |l| l.split.map{ |e| e =~ /[a-z]+/ ? e.to_sym : e.to_i } }

class Program

    def initialize code
        @code = code
        @current_instruction = 0
        @data = {}
    end

    def exec_instruction instruction
        self.send(*instruction)
    end

    def execute
        while @current_instruction < @code.size do
            exec_instruction @code[@current_instruction]
            @current_instruction += 1
        end
    end

    def snd b
        @last_played = val(b)
    end

    def set b, c
        @data[b] = val(c)
    end

    def add b, c
        @data[b] = val(b) + val(c)
    end

    def mul b, c
        @data[b] = val(b) * val(c)
    end

    def mod b, c
        @data[b] = val(b) % val(c)
    end

    def rcv b
        if val(b) > 0 and not @first_recovered
            @first_recovered = @last_played
            @current_instruction = @code.size
        end
    end

    def jgz b, c
        @current_instruction += val(c) - 1 if val(b) > 0
    end

    def val x
        case x
        when Symbol
            @data.fetch(x, 0)
        else
            x
        end
    end

    def recovered
        @first_recovered
    end
end

PROG = Program.new DATA
PROG.execute

P1 = PROG.recovered

class ProgramWithDoc < Program
    def initialize code, id
        super code
        @id = id
        @data[:p] = id
        @queue = []
        @waiting = false
        @out = []
        @sent = 0
    end

    def exec_instruction instruction
        self.send(*instruction)
    end

    def execute
        while @current_instruction < @code.size do
            if @code[@current_instruction].first == :rcv and @queue.size == 0
                @waiting = true
                break
            end
            exec_instruction @code[@current_instruction]
            @current_instruction += 1
        end
    end

    def snd x
        @out.push val(x)
        @sent += 1
    end

    def rcv x
        @data[x] = @queue.shift
    end

    def waiting?
        @waiting
    end

    def terminated?
        @current_instruction >= @code.size
    end

    def receive(arr)
        @queue += arr if arr
        @waiting = false if @queue.size > 0
    end

    def retrieve_sent
        @out.shift @out.size
    end

    def send_count
        @sent
    end
end

def solve_p2
    prog1 = ProgramWithDoc.new DATA, 0
    prog2 = ProgramWithDoc.new DATA, 1

    n = 0

    loop do
        prog1.execute
        prog2.execute
        prog1.receive prog2.retrieve_sent
        prog2.receive prog1.retrieve_sent
        break if (prog1.terminated? or prog1.waiting?) and (prog2.terminated? or prog2.waiting?)
    end

    prog2.send_count
end

P2 = solve_p2

puts "Part 1: %s" % P1
puts "Part 2: %s" % P2

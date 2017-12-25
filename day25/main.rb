class Object
    def yield_self
        yield self
    end
end

DATA = File.read('data.txt')
    .yield_self do |txt|
        start = txt.scan(/Begin in state (\w+)/).first.first
        step_count = txt.scan(/Perform a diagnostic checksum after (\d+) steps/).first.first.to_i

        make_step = lambda { |input| write, direction, next_state = input; { write: write.to_i, direction: direction.to_sym, next: next_state} }

        steps = txt.scan(/In state (\w):\n.*?\n.*?(\d).\n.*?(left|right).\n.*?state (\w).\n.*?\n.*?(\d).\n.*?(left|right).\n.*?state (\w)./m)
            .map{ |a| [a.first, {0 => make_step.call(a[1...4]), 1 => make_step.call(a[4...7])}] }
            .to_h

        [start, step_count, steps]
    end

def solve_p1 data
    states = {}
    current_state = data.first
    cursor = 0
    get_instruction = lambda { |state, value| data.last[state][value] }

    data[1].times do
        instr = get_instruction.call current_state, states.fetch(cursor, 0)
        states[cursor] = instr[:write]
        cursor += instr[:direction] == :right ? 1 : -1
        current_state = instr[:next]
    end
    states.values.sum
end

P1 = solve_p1(DATA)

puts "Part 1: %s" % P1

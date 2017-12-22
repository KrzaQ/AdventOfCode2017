class Object
    def yield_self
        yield self
    end
end

DATA = File.read('data.txt')
    .split("\n")
    .map(&:strip)
    .join
    .each_char
    .map{ |c| c == '#' }
    .yield_self{ |s| s.each_slice(Math.sqrt(s.size)) }

MAP = DATA
    .to_a
    .reverse
    .each_with_index
    .map{ |row, y| row.each_with_index.map{ |c, x| [x, y, c] } }
    .flatten(1)
    .map{ |x, y, c| [[x-DATA.size/2, y-DATA.size/2], c] }
    .to_h

def solve_p1(data)
    virused = 0
    current_direction = [ [0, 1], [1, 0], [0, -1], [-1, 0] ]
    pos = [0, 0]

    10_000.times do
        infected = data.fetch(pos, false)
        current_direction.rotate!(infected ? 1 : -1)
        data.store(pos, !infected)
        virused += 1 unless infected
        pos = pos.zip(current_direction.first).map(&:sum)
    end
    virused
end

P1 = solve_p1 MAP.clone
p P1


def solve_p2(data)
    virused = 0
    current_direction = [ [0, 1], [1, 0], [0, -1], [-1, 0] ]
    direction_choice = {
        clean: -1,
        weakened: 0,
        infected: 1,
        flagged: 2,
    }
    states = direction_choice.keys
    pos = [0, 0]
    # p states
    10_000_000.times do
    # 100.times do
        state = data.fetch(pos, :clean)
        state = :clean if state == false
        state = :infected if state == true
        current_direction.rotate!(direction_choice[state])
        new_state = states[(states.index(state) + 1) % states.size]
        # p [state, new_state, direction_choice[state]]
        data.store(pos, new_state)
        virused += 1 if state == :weakened
        pos = pos.zip(current_direction.first).map(&:sum)
    end
    # [data, virused]
    virused
end

P2 = solve_p2 MAP.clone
p P2
exit 
# GRID_SIZE = 4
# str = (-GRID_SIZE..GRID_SIZE)
#     .to_a
#     .reverse
#     .map{ |y| (-GRID_SIZE..GRID_SIZE).map{ |x| [x, y] } }
#     .flatten(1)
#     .map do |x, y|
#         case P2.first.fetch([x, y], :clean)
#         when :clean
#             '.'
#         when false
#             '.'
#         when :infected
#             '#'
#         when true
#             '#'
#         when :weakened
#             'W'
#         when :flagged
#             'F'
#         else
#             '?'
#         end
#     end
#     .each_slice(GRID_SIZE * 2 + 1)
#     .to_a
#     .map(&:join)
#     .join("\n")

# puts str
# p P2.last

require 'citrus'

DATA = File.read('data.txt').each_line.map(&:strip).to_a
# DATA = File.read('data.txt').each_line.map(&:strip).to_a

# Parser =
 p Citrus.load 'grammar'

x = Dupa.parse DATA[2]
p x

# parsed

exit
# class Graph


    # def scan_line line
        # /(\w+) \((\d+)\)/
    # end
# end
# 
# g = Graph.new

graph = {}
rev = {}

DATA
    .join("\n")
    .scan(/^(\w+) \(\d+\) -> (.+)$/)
    .each do |k, v|
        graph[k] = v.split(", ")
        graph[k].each do |r|
            rev[r] = k
        end
    end
    # .map{ |k, v| { node: k, children: v.split(", ") } }
# p graph





f = graph.keys.first
top = f
while rev.fetch(f, nil) do 
    f = rev[f]
    top = f
end

p top


weights = DATA
    .join("\n")
    .scan(/^(\w+) \((\d+)\)/)
    .map{ |k, v| [k, v.to_i] }
    .to_h


$cache = {}
def calc_children_weight(w, g, name)
    return $cache[name] if $cache.has_key? name
    result = g.fetch(name, []).map{ |n| calc_children_weight(w, g, n) }.sum + w[name]
    $cache[name] = result
    result
end

incorrect = graph.keys
    .select{ |k| x = graph[k].map{ |c| calc_children_weight(weights, graph, c) }.sort; x.first != x.last }

p incorrect
p incorrect.reject{ |n| graph[n].any?{ |c| incorrect.include? c } }

p calc_children_weight(weights, graph, 'aurik')
graph['aurik'].each do |c| p [c, calc_children_weight(weights, graph, c)] end

# p calc_children_weight(weights, graph, top)

# puts "Part 1: %s" % P1
# puts "Part 2: %s" % P2

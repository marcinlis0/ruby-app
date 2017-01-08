class DijkstraController < ApplicationController

    def index
      @from_text_of_nodes = params[:text_of_nodes]

        arr = @from_text_of_nodes.to_s.split(/,/).map(&:to_i)

       if arr.size % 3 != 0
        @code = "błąd"
        end
        if arr.size % 3 == 0
          @code = arr.size

        arraysize = 0
      #  graph = Graph.new
      #  (1..arr.size).each { |node| graph.push node }
        while arraysize < arr.size
        #  graph.make_edge arr[arraysize], arr[arraysize+1], arr[arraysize+2]
          arraysize += 3
        end
        graph = Graph.new
        (1..6).each { |node| graph.push node }
        graph.make_edge 1, 2, 7
        graph.make_edge 1, 3, 9
        graph.make_edge 1, 6, 14
        graph.make_edge 2, 3, 10
        graph.make_edge 2, 4, 15
        graph.make_edge 3, 4, 2
        graph.make_edge 3, 6, 2
        graph.make_edge 4, 5, 9
        graph.make_edge 5, 6, 9

        returnarr = graph.dijkstra(1).to_s.split(/,/).map(&:to_i)

        @code = returnarr
        #graph = Graph.new
        #(1..6).each { |node| graph.push node }
      #   1,2,7,1,3,9,1,6,14,2,3,10,2,4,15,3,4,2,3,6,2,4,5,9,5,6,9
end
end

    #    end
    #  else
    #    @code = arr


  end

class Edge
  attr_accessor :vert1, :vert2, :weight

  def initialize(vert1, vert2, weight)
    @vert1 = vert1
    @vert2 = vert2
    @weight = weight
  end
end
# graf
class Graph < Array
  attr_reader :edges

  def initialize
    @edges = []
  end

  def make_edge(vert1, vert2, weight, weight2 = weight)
    @edges.push Edge.new(vert1, vert2, weight) # 1->2 inna waga niz 2->1
    @edges.push Edge.new(vert2, vert1, weight2) # (do zaimplementowania)+
  end

  def neighbors(vertex)
    neighbors = []
    @edges.each do |edge|
      neighbors.push edge.vert2 if edge.vert1 == vertex
    end
    neighbors.uniq
  end

  def edge_length(vert1, vert2)
    @edges.each do |edge|
      return edge.weight if edge.vert1 == vert1 && edge.vert2 == vert2
    end
    nil
  end

  # main alg
  def dijkstra(vert1, vert2 = nil)
    distances = {}
    previouses = {}
    each do |vertex|
      distances[vertex] = nil # Infinity
      previouses[vertex] = nil
    end
    distances[vert1] = 0
    vertices = clone
    until vertices.empty?
      nearest_vertex = vertices.inject do |a, b|
        next b unless distances[a]
        next a unless distances[b]
        next a if distances[a] < distances[b]
        b
      end
      break unless distances[nearest_vertex] # Infinity
      if vert2 && nearest_vertex == vert2
        path = get_path(previouses, vert1, vert2)
        return { path: path, distance: distances[vert2] }
      end
      neighbors = vertices.neighbors(nearest_vertex)
      neighbors.each do |vertex|
        alt = distances[nearest_vertex] + vertices.edge_length(nearest_vertex, vertex)
        next unless distances[vertex].nil? || alt < distances[vertex]
        distances[vertex] = alt
        previouses[vertex] = nearest_vertex
        # decrease-key v in Q # ???
      end
      vertices.delete nearest_vertex
    end
    if vert2
      return nil
    else
      paths = {}
      distances.each { |k, _v| paths[k] = get_path(previouses, vert1, k) }
      return { paths: paths, distances: distances }
    end
  end

  private

  def get_path(previouses, vert1, vert2)
    path = get_path_recursively(previouses, vert1, vert2)
    path.is_a?(Array) ? path.reverse : path
  end

  # Unroll through previouses array until we get to source
  def get_path_recursively(previouses, vert1, vert2)
    return vert1 if vert1 == vert2
    raise ArgumentError, "No path from #{vert1} to #{vert2}" if previouses[vert2].nil?
    [vert2, get_path_recursively(previouses, vert1, previouses[vert2])].flatten
  end
end

#graph = Graph.new
#(1..6).each { |node| graph.push node }
#graph.make_edge 1, 2, 7
#graph.make_edge 1, 3, 9
#graph.make_edge 1, 6, 14
#graph.make_edge 2, 3, 10
#graph.make_edge 2, 4, 15
#graph.make_edge 3, 4, 2
#graph.make_edge 3, 6, 2
#graph.make_edge 4, 5, 9
#graph.make_edge 5, 6, 9

# p graph.edges.size
# p graph
# p graph.edge_length(2, 1)
# p graph.neighbors(1)
# p graph.dijkstra(1)
#p graph.dijkstra(1)

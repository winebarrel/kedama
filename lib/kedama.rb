require 'digest/md5'

module Kedama
  class ConsitentHash
    def initialize(nodes)
      @circle = []
      @names = {}

      total_weight = nodes.values.inject {|r, i| r + i}

      nodes.each do |name, weight|
        repls = (40.0 * nodes.length * weight / total_weight).floor

        repls.times do |i|
          hs = hash_values("#{name}-#{i}")

          hs.each do |h|
            @circle << h
            @names[h] = name
          end
        end
      end

      @circle.sort!
    end

    def to_a
      @circle.map do |h|
        [h, @names[h]]
      end
    end

    def [](key)
      point = search(key.to_str)
      @names[point]
    end

    private
    def hash_values(str)
      digest = Digest::MD5.digest(str)
      hs = []

      until digest.empty?
        bs = digest.slice!(0, 4)
        hs << (bs[3] << 24) + (bs[2] << 16) + (bs[1] << 8) + bs[0]
      end

      return hs
    end

    def hashi(str)
      digest = Digest::MD5.digest(str)
      (digest[3] << 24) + (digest[2] << 16) + (digest[1] << 8) + digest[0]
    end

    def search(key)
      key_hash = hashi(key)
      lowp = 0
      highp = @circle.length

      while true
        midp = (lowp + highp) / 2;

        return @circle.first if midp == @circle.length

        midval = @circle[midp];
        midval1 = midp.zero? ? 0 : @circle[midp - 1]

        if midval1 < key_hash and key_hash <= midval
          return midval
        end

        if midval < key_hash
          lowp = midp + 1
        else
          highp = midp - 1
        end

        return @circle.first if lowp > highp
      end
    end
  end # ConsitentHash

  class Nodes
    attr_reader :nodes

    def initialize
      @nodes = {}
    end

    def add(name, weight)
      @nodes[name.to_str] = weight.to_int
    end

    def delete(name)
      @nodes.delete(name)
    end

    def to_hash
      ConsitentHash.new(@nodes)
    end
  end # Nodes

end # Kedama

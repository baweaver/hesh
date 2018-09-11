require "hesh/version"

class Hesh
  # Merely an identity function, rather boring, it just returns whatever
  # you happen to give it!
  IDENTITY_FN = -> v { v }

  # We prefer the new and shiny here, yes we do.
  PREFER_NEW_FN = -> k, o, n { n }

  def initialize
    raise 'Why no no no, hesh is not to be made! Not yet!'
  end

  class << self
    # Creates a Hash of something, I'm not sure what, you tell me!
    #
    # @param &fn [Proc]
    #   Function for default value of the hash, yielding the hash and
    #   key if ya need them
    #
    # @return [Hash[Any, Any]]
    def of(&fn)
      Hash.new { |h, k| h[k] = fn.call(h, k) }
    end

    # Creates a Hash of arrays
    #
    # @return [Hash[Any, Array]]
    def of_array
      Hash.new { |h, k| h[k] = [] }
    end

    # Creates a Hash of hashes
    #
    # @return [Hash[Any, Hash]]
    def of_hash
      Hash.new { |h, k| h[k] = {} }
    end

    # Creates an infinite hash
    #
    # @return [Hash[Any, Hash]]
    def of_infinite_hash
      Hash.new { |h, k| h[k] = Hash.new(&h.default_proc) }
    end

    # Gets the counts of items from a list by using a function
    #
    # @param list [Array]
    #   List of items
    #
    # @param &fn [Proc]
    #   Function to count by, identity if not provided
    #
    # @return [Hash[Any, Integer]]
    #   Counts
    def count_from(list, &fn)
      fn ||= IDENTITY_FN
      list.each_with_object(Hash.new(0)) { |v, h| h[fn[v]] += 1 }
    end

    # Inverts the relationship of a hash of arrays
    #
    # @param hash [Hash[Any, Array]]
    #   Hash with a value pointing to a collection to invert
    #
    # @example
    #   numbers_to_letters = { 1 => %w(a b), 2 => %w(b c), 3 => %w(a c) }
    #   Hesh.invert_relation(numbers_to_letters)
    #   => { "a" => [1, 3], "b" => [1, 2], "c" => [2, 3] }
    #
    # @return [Hash[Any, Array]]
    #   Inverted relation
    def invert_relation(hash)
      hash.each_with_object(Hesh.of_array) { |(k, vs), h|
        vs.each { |v| h[v] << k }
      }
    end

    # Merges a series of hashes and sums their values
    #
    # @param *hashes [Array[Hash]]
    #   Collection of hashes
    #
    # @return [Hash[Any, Integer]]
    #   Summed hash
    def merge_sum(*hashes)
      hashes.reduce(Hash.new(0), &merges { |k, o, n| o + n })
    end

    # Merges a series of hashes and joins their values
    #
    # @param *hashes [Array[Hash]]
    #   Collection of hashes
    #
    # @return [Hash[Any, Array]]
    #   Joined hash
    def merge_join(*hashes)
      hashes.reduce(Hesh.of_array, &merges { |k, o, n| o + n })
    end

    # Merges a series of hashes with a function
    #
    # @param *hashes [Array[Hash]]
    #   Collection of hashes
    #
    # @return [Hash[Any, Any]]
    #   Merged hash
    def merge_with(*hashes, &fn)
      hashes.reduce({}, &merges(&fn))
    end

    # Merges a series of hashes infintely deep with a function
    #
    # @param *hashes [Array[Hash]]
    #   Collection of hashes
    #
    # @param &fn [Proc]
    #   Function for joining values, defaults to preferring newest value
    #
    # @return [Hash[Any, Any]]
    #   Joined hash
    def merge_deep(*hashes, &fn)
      fn ||= PREFER_NEW_FN

      hashes.reduce({}, &merges { |k, o, n|
        o.is_a?(Hash) ? merge_deep(o, n, &fn) : fn[k, o, n]
      })
    end

    private def merges(&fn)
      -> a, b { a.merge(b, &fn) }
    end
  end
end

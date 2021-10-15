# frozen_string_literal: true

module RubyCExperiments
  module Ruby
    module LevenshteinDistance
      class << self
        # Source: http://rosettacode.org/wiki/Levenshtein_distance#Ruby
        # Implementation of the wikipedia algorithm.
        # Invariant is that for current loop indices i and j, costs[k] for k < j
        # contains lev(i, k) and for k >= j contains lev(i-1, k).
        # The inner loop body restores the invariant for the new value of j.
        def with_wikipedia_algorithm(a, b)
          a, b = a.downcase, b.downcase
          costs = Array(0..b.length) # i == 0
          (1..a.length).each do |i|
            costs[0], nw = i, i - 1  # j == 0; nw is lev(i-1, j)
            (1..b.length).each do |j|
              costs[j], nw = [costs[j] + 1, costs[j-1] + 1, a[i-1] == b[j-1] ? nw : nw + 1].min, costs[j]
            end
          end
          costs[b.length]
        end

        # https://github.com/rubygems/rubygems/blob/master/lib/rubygems/text.rb#L55
        def with_rubygems_algorithm(str1, str2)
          n = str1.length
          m = str2.length
          return m if n.zero?
          return n if m.zero?

          d = (0..m).to_a
          x = nil

          # to avoid duplicating an enumerable object, create it outside of the loop
          str2_codepoints = str2.codepoints

          str1.each_codepoint.with_index(1) do |char1, i|
            j = 0
            while j < m
              cost = (char1 == str2_codepoints[j]) ? 0 : 1
              x = min3(
                d[j + 1] + 1, # insertion
                i + 1,      # deletion
                d[j] + cost # substitution
              )
              d[j] = i
              i = x

              j += 1
            end
            d[m] = x
          end

          x
        end

        private

        def min3(a, b, c) # :nodoc:
          if a < b && a < c
            a
          elsif b < c
            b
          else
            c
          end
        end
      end
    end
  end
end

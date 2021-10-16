# frozen_string_literal: true

require 'inline'

# Read more here
# https://www.rubydoc.info/gems/RubyInline/3.12.4

module RubyCExperiments
  module Inline
    class LevenshteinDistance
      class << self
        # Wrapper to have the same interface here
        def calculate(a, b)
          new.levenshtein(a, b)
        end
      end

      inline do |builder|
        builder.include '<string.h>'
        builder.include '<stdlib.h>'
        builder.include '<stdint.h>'

        # Inline can not work with 'size_t' so I had to replace to 'unsigned long'
        # but it might be different depending on OS where it is used,
        # so it might not work properly at other machines
        # but at least must work fine at linux systems where it is
        # typedef unsigned long size_t;
        # More here https://stackoverflow.com/a/22023084/1052277

        # Adapted version of this algorhythm implementation
        # https://github.com/wooorm/levenshtein.c

        builder.c '
          unsigned long levenshtein(const char *a, const char *b) {
            const unsigned long length = strlen(a);
            const unsigned long bLength = strlen(b);

            // Shortcut optimizations / degenerate cases.
            if (a == b) {
              return 0;
            }

            if (length == 0) {
              return bLength;
            }

            if (bLength == 0) {
              return length;
            }

            unsigned long *cache = calloc(length, sizeof(unsigned long));
            unsigned long index = 0;
            unsigned long bIndex = 0;
            unsigned long distance;
            unsigned long bDistance;
            unsigned long result;
            char code;

            // initialize the vector.
            while (index < length) {
              cache[index] = index + 1;
              index++;
            }

            // Loop.
            while (bIndex < bLength) {
              code = b[bIndex];
              result = distance = bIndex++;
              index = SIZE_MAX;

              while (++index < length) {
                bDistance = code == a[index] ? distance : distance + 1;
                distance = cache[index];

                cache[index] = result = distance > result
                  ? bDistance > result
                    ? result + 1
                    : bDistance
                  : bDistance > distance
                    ? distance + 1
                    : bDistance;
              }
            }

            free(cache);

            return result;
          }'
      end
    end
  end
end

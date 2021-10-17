namespace :ruby_c_experiments do
  namespace :benchmarks do
    desc 'Levenshtein distance benckmarks'
    task :levenshtein_distance do
      # This file is required here since some bundle files for Native C extensions
      # might not be compiled first and this might fail the Rakefile load,
      # so it is loaded here, only where it is really needed
      require 'ruby_c_experiments'

      # Read more about benchmarking
      # https://hackernoon.com/how-benchmarking-your-code-will-improve-your-ruby-skills-cre3ugd

      require 'benchmark/ips'

      # Sample data and benchmark logic idea (run_with_data) have been derived
      # from this repository
      # https://github.com/christianscott/levenshtein-distance-benchmarks
      lines = File.readlines(File.expand_path('data/levenshtein_distance.txt', __dir__))

      prepare_becnhmark_operation = ->(klass:, calculation_method_name:) do
        # Start comparison with empty string
        last_value = ''

        # https://apidock.com/ruby/v2_5_5/Enumerable/cycle
        lines_cycle_enumerator = lines.cycle

        # Prepare callable closure that will be called in the benchmark loop
        operation = -> do
          line = lines_cycle_enumerator.next
          klass.public_send(calculation_method_name, last_value, line)
          last_value = line
        end

        # Store some meta data here to let it be displayed later
        {
          klass: klass,
          calculation_method_name: calculation_method_name,
          operation: operation
        }
      end

      implementations = [
        prepare_becnhmark_operation.call(
          klass: RubyCExperiments::Ruby::LevenshteinDistance,
          calculation_method_name: :with_rubygems_algorithm
        ),
        prepare_becnhmark_operation.call(
          klass: RubyCExperiments::Ruby::LevenshteinDistance,
          calculation_method_name: :with_wikipedia_algorithm
        ),
        prepare_becnhmark_operation.call(
          klass: RubyCExperiments::Inline::LevenshteinDistance,
          calculation_method_name: :calculate
        ),
        prepare_becnhmark_operation.call(
          klass: RubyCExperiments::Native::LevenshteinDistance,
          calculation_method_name: :calculate
        ),
        prepare_becnhmark_operation.call(
          klass: RubyCExperiments::FFI::LevenshteinDistance,
          calculation_method_name: :calculate
        ),
        prepare_becnhmark_operation.call(
          klass: RubyCExperiments::Fiddle::LevenshteinDistance,
          calculation_method_name: :levenshtein
        )
      ]

      puts "==================== Levenshtein Distance Benchmarks ===================="
      Benchmark.ips do |x|
        implementations.each do |bench_config|
          label = [bench_config[:klass],bench_config[:calculation_method_name]].join('.')
          x.report(label) do
            bench_config[:operation].call
          end
        end

        x.compare!
      end
    end
  end
end

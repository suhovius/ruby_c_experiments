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

      require 'benchmark'
      require 'benchmark/ips'
      require 'benchmark/memory'

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

      run_for = ->(implementations:, x:) do
        implementations.each do |bench_config|
          label = [bench_config[:klass],bench_config[:calculation_method_name]].join('.')
          x.report(label) do
            bench_config[:operation].call
          end
        end
      end

      puts "==================== Levenshtein Distance Benchmarks =========================\n"

      puts "==================== Elapsed Time ============================================"
      Benchmark.bmbm do |x|
        long_words = %w[Supercalifragilisticexpialidocious Honorificabilitudinitatibus]

        implementations.each do |bench_config|
          label = [bench_config[:klass],bench_config[:calculation_method_name]].join('.')
          x.report(label) do
            bench_config[:klass].public_send(
              bench_config[:calculation_method_name], *long_words
            )
          end
        end
      end
      puts "\n"

      puts "==================== Iterations Per Second ====================================\n"
      Benchmark.ips do |x|
        run_for.call(implementations: implementations, x: x)

        x.compare!
      end
      puts "\n"

      puts "==================== Memory ===================================================\n"
      Benchmark.memory do |x|
        run_for.call(implementations: implementations, x: x)

        x.compare!
      end
      puts "\n"
    end
  end
end

namespace :ruby_c_experiments do
  namespace :benchmarks do
    desc 'Levenshtein distance benckmarks'
    task :levenshtein_distance do
      # Sample data and benchmark logic idea (run_with_data) have been derived
      # from this repository
      # https://github.com/christianscott/levenshtein-distance-benchmarks
      lines = File.readlines(File.expand_path('data/levenshtein_distance.txt', __dir__))

      # Fix benchmark logic, use iterations and call for each iteration
      # x.iterations. Learn about benchmarking
      # https://hackernoon.com/how-benchmarking-your-code-will-improve-your-ruby-skills-cre3ugd
      run_with_data = ->(klass:, calculation_method_name:, lines:) do
        last_value = ''
        lines.each do |line|
          klass.public_send(calculation_method_name, last_value, line)
          last_value = line
        end
      end

      implementations = [
        [RubyCExperiments::Native::LevenshteinDistance, :calculate],
        [RubyCExperiments::Ruby::LevenshteinDistance, :with_rubygems_algorithm],
        [RubyCExperiments::Ruby::LevenshteinDistance, :with_wikipedia_algorithm],
        [RubyCExperiments::Inline::LevenshteinDistance, :calculate]
      ]

      puts "--- IPS For Big File Input ----------------------------"
      Benchmark.ips do |x|
        implementations.each do |bench_config|
          label = [bench_config[0],bench_config[1]].join('.')
          x.report(label) do
            run_with_data.call(
              klass: bench_config[0],
              calculation_method_name: bench_config[1],
              lines: lines
            )
          end
        end

        x.compare!
      end

      puts "--- IPS For One Long Sentence --------------------------"

      text_a = <<~TEXT
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
        veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
        commodo consequat. Duis aute irure dolor in reprehenderit in voluptate
        velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint
        occaecat cupidatat non proident, sunt in culpa qui officia deserunt
        mollit anim id est laborum.
      TEXT

      text_b = <<~TEXT
        Lorem UpsAm OLolor sit amet, OTHER CHANGE adipiscing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim
        veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
        commodo consequat. Duis aute irure CAT in reprehenderit in voluptate
        velit esse cillum John eu fugiat DOE pariatur. Excepteur DOG
        occaecat cupidatat non proident, sunt in culpa qui officia deserunt
        mollit anim id est laborum.
      TEXT

      Benchmark.ips do |x|
        implementations.each do |bench_config|
          label = [bench_config[0],bench_config[1]].join('.')
          x.report(label) do
            bench_config[0].public_send(
              bench_config[1], text_a, text_b
            )
          end
        end

        x.compare!
      end
    end
  end
end

namespace :ruby_c_experiments do
  namespace :benchmarks do
    desc 'Levenshtein distance benckmarks'
    task :levenshtein_distance do
      lines = File.readlines(File.expand_path('data/levenshtein_distance.txt', __dir__))

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
    end
  end
end

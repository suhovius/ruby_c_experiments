require 'mkmf'

# mkmf documentation
# https://github.com/ruby/ruby/blob/master/lib/mkmf.rb

# Generates the Makefile for your extension, passing along any options and
# preprocessor constants that you may have generated through other methods.

create_makefile 'ruby_c_experiments/levenstein_distance/levenstein_distance'

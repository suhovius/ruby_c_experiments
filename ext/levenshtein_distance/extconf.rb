require 'mkmf'

# mkmf documentation
# https://github.com/ruby/ruby/blob/master/lib/mkmf.rb

# Generates the Makefile for your extension, passing along any options and
# preprocessor constants that you may have generated through other methods.

# Read more here regarding including the c headers from the sub folders
# https://stackoverflow.com/a/35842162/1052277

ext_dir_path = 'ruby_c_experiments/levenshtein_distance/levenshtein_distance'

dir_config(ext_dir_path)

external_folder = '../levenshtein'

# enum all source files
$srcs = ['levenshtein_distance.c', "#{external_folder}/levenshtein.h"]

# add include path to the internal folder
# $(srcdir) is a root folder, where 'extconf.rb' is stored
$INCFLAGS << " -I$(srcdir)/#{external_folder}"

# add folder, where compiler can search source files
$VPATH << "$(srcdir)/#{external_folder}"

create_makefile(ext_dir_path)

#include <ruby.h>
#include "levenshtein.h"

// https://github.com/wooorm/levenshtein.c original levenshtein C code is defined here

VALUE calculate(VALUE self, VALUE a, VALUE b) {
    // Check that both arguments are strings
    Check_Type(a, T_STRING);
    Check_Type(b, T_STRING);

    // Extract value from the Ruby String to C string
    char *cA = StringValueCStr(a);
    char *cB = StringValueCStr(b);

    // Calculate Levenshtein distance
    size_t cDistance = levenshtein(cA, cB);

    // Convert size_t wich might be unsigned long long to Number with macro ULL2NUM
    VALUE rbDistance = ULL2NUM(cDistance);

    return rbDistance;
}

void Init_levenshtein_distance() {
    VALUE mRubyCExperiments = rb_define_module("RubyCExperiments");
    VALUE mNative = rb_define_module_under(mRubyCExperiments, "Native");
    VALUE mLevenshteinDistance  = rb_define_module_under(mNative, "LevenshteinDistance");
    rb_define_singleton_method(mLevenshteinDistance, "calculate", calculate, 2);
}

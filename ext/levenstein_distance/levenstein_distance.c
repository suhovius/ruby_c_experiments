#include <ruby.h>
#include "levenshtein.h"

VALUE calculate(VALUE self, VALUE a, VALUE b) {
    // Check that both arguments are strings
    Check_Type(a, T_STRING);
    Check_Type(b, T_STRING);

    // Extract value from the Ruby String to C string
    char *cA = StringValueCStr(a);
    char *cB = StringValueCStr(b);

    // Calculate Levenstein distance
    size_t cDistance = levenshtein(cA, cB);

    // Convert size_t wich might be unsigned long long to Number with macro ULL2NUM
    VALUE rbDistance = ULL2NUM(cDistance);

    return rbDistance;
}

void Init_levenstein_distance() {
    VALUE mRubyCExperiments = rb_define_module("RubyCExperiments");
    VALUE mLevensteinDistance  = rb_define_module_under(mRubyCExperiments, "LevensteinDistance");
    rb_define_singleton_method(mLevensteinDistance, "calculate", calculate, 2);
}

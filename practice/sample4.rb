# Q4. Are these two statements equivalent? Why or Why Not?
#   1. x, y = "hello", "hello"
#   2. x = y = "hello"

# Because the first is parallel assignment, it is creating two different objects from
# two different string literals, and we expect them to have different object ID's. It's
# functionally the same as doing two separate assignments in two lines of code.

str1, str2 = "hello", "hello"

puts ("\nParallel initialization of Strings")
puts ("str1 value = #{str1}, object_id = #{str1.object_id}")
puts ("str2 value = #{str2}, object_id = #{str2.object_id}")

# The second example is assigning the literal to the first variable, and then copying
# that reference to the second variable (working right-to-left), so they'll both be
# references to the same object.

str3 = str4 = "hello"

puts ("\nTransitive initialization of Strings")
puts ("str3 value = #{str3}, object_id = #{str3.object_id}")
puts ("str4 value = #{str4}, object_id = #{str4.object_id}")


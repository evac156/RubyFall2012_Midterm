# Q3. What is the difference between how a String, a symbol, a FixNum, and a Float are stored in Ruby?

# Try these out. We know that for a Symbol and a FixNum, the same value is always stored at the same
# place. And we know for a String, it's always different. But what about floats? Easiest way to check
# is via the object_id property.

# For symbols, these three will all reference the same object

sym1 = :symbol1
sym2 = :symbol1
sym3 = sym1

puts ("Symbol values and object ID's")
puts ("sym1 value = #{sym1.inspect}, object_id = #{sym1.object_id}")
puts ("sym2 value = #{sym2.inspect}, object_id = #{sym2.object_id}")
puts ("sym3 value = #{sym3.inspect}, object_id = #{sym3.object_id}")

# For Strings, even though they have the same value, str1 and str2 are different
# objects, and str3 refers to the same object as str1

str1 = "Sample String"
str2 = "Sample String"
str3 = str1
str4 = String(str1)

puts ("\nInitializing Strings")
puts ("str1 value = #{str1}, object_id = #{str1.object_id}")
puts ("str2 value = #{str2}, object_id = #{str2.object_id}")
puts ("str3 value = #{str3}, object_id = #{str3.object_id}")
puts ("str4 value = #{str4}, object_id = #{str4.object_id}")

# When we modify the string in place, it remains a reference to the same object,
# but the content (state) of that object has changed. All three of these should
# retain the same object_id as before, but str1 and str3 now point to an upcased
# value.

str1.upcase!

puts ("\nAfter upcasing String str1 in place")
puts ("str1 value = #{str1}, object_id = #{str1.object_id}")
puts ("str2 value = #{str2}, object_id = #{str2.object_id}")
puts ("str3 value = #{str3}, object_id = #{str3.object_id}")
puts ("str4 value = #{str4}, object_id = #{str4.object_id}")

# For Fixnums (integers, usually?) we should see the same behavior as for symbols,
# at first: All three of these refer to the same object in memory.

fn1 = 42
fn2 = 42
fn3 = fn1

puts ("\nInitializing Fixnums")
puts ("fn1 value = #{fn1.inspect}, object_id = #{fn1.object_id}")
puts ("fn2 value = #{fn2.inspect}, object_id = #{fn2.object_id}")
puts ("fn3 value = #{fn3.inspect}, object_id = #{fn3.object_id}")

# But when we start modifying the values, even though it looks like we are modifying
# a value "in place", we aren't actually doing that. This will get the value of fn1,
# multiply it, get the reference to the resulting new FixNum, and assigns that reference
# to fn1. It will not change fn2 or fn3.

fn1 *= 3

puts ("\nAfter multiplying Fixnum fn1")
puts ("fn1 value = #{fn1.inspect}, object_id = #{fn1.object_id}")
puts ("fn2 value = #{fn2.inspect}, object_id = #{fn2.object_id}")
puts ("fn3 value = #{fn3.inspect}, object_id = #{fn3.object_id}")

# According to the RDoc, Fixnum extends Integer. Do we see the same behavior with
# Integer objects?

int1 = Integer(42)
int2 = Integer(42)
int3 = Integer(int1)

# Looks like Integer is just smoke and mirrors. Because these show the same behavior,
# and if we dump them out, they're actually Fixnums after all.

puts ("\nInitializing Integers")
puts ("int1 class = #{int1.class}, value = #{int1.inspect}, object_id = #{int1.object_id}")
puts ("int2 class = #{int3.class}, value = #{int2.inspect}, object_id = #{int2.object_id}")
puts ("int3 class = #{int3.class}, value = #{int3.inspect}, object_id = #{int3.object_id}")

# But, what if we use very large integer values, which exceed the size of a machine word?
# 2^61 is a Fixnum on my machine, 2^62 is a Bignum:

int4 = Integer(2 ** 61) # 2^61, still a Fixnum
int5 = Integer(2 ** 62) # 2^62, now a Bignum
int6 = Integer(2 ** 62) # Same Bignum, or different?
int7 = int5;

puts ("\nInitializing more Integers, should see some Bignums")
puts ("int4 class = #{int4.class}, value = #{int4.inspect}, object_id = #{int4.object_id}")
puts ("int5 class = #{int5.class}, value = #{int5.inspect}, object_id = #{int5.object_id}")
puts ("int6 class = #{int6.class}, value = #{int6.inspect}, object_id = #{int6.object_id}")
puts ("int7 class = #{int7.class}, value = #{int7.inspect}, object_id = #{int7.object_id}")

# And if we modify the value of a Bignum, do we get a new object, or the original object with
# a modified value?

int5 *= 3
int6 *= 3

puts ("\nAfter multiplying Bignums")
puts ("int5 class = #{int5.class}, value = #{int5.inspect}, object_id = #{int5.object_id}")
puts ("int6 class = #{int6.class}, value = #{int6.inspect}, object_id = #{int6.object_id}")
puts ("int7 class = #{int7.class}, value = #{int7.inspect}, object_id = #{int7.object_id}")

# And floats? They're interesting. Since fixnums are scalars, we can assign each one
# to a place in memory, and there's no question of anything coming in between two
# consecutive values. But for floats, we can't really do that, because there are
# an infinite number of values between any two floats; there's really no such thing
# as "consecutive". So we expect that we'll get a new object each time we create a
# Float, even if they have the same value. The only way to get the same object is
# to actually assign one variable to another, copying the reference. fl5 and fl6
# both refer to the same object as fl1. Using the Float(...) method does not create
# a new instance the argument is a variable; it just uses the same reference.

fl1 = Float(17.3)
fl2 = Float(17.3)
fl3 = 17.3
fl4 = 17.3
fl5 = fl1
fl6 = Float(fl1)

puts ("\nInitializing floats")
puts ("fl1: class = #{fl1.class}; value = #{fl1.inspect}; object_id = #{fl1.object_id}")
puts ("fl2: class = #{fl2.class}; value = #{fl2.inspect}; object_id = #{fl2.object_id}")
puts ("fl3: class = #{fl3.class}; value = #{fl3.inspect}; object_id = #{fl3.object_id}")
puts ("fl4: class = #{fl4.class}; value = #{fl4.inspect}; object_id = #{fl4.object_id}")
puts ("fl5: class = #{fl5.class}; value = #{fl5.inspect}; object_id = #{fl5.object_id}")
puts ("fl6: class = #{fl6.class}; value = #{fl6.inspect}; object_id = #{fl6.object_id}")

# Now, if we modify the value, will it behave like a String, or like a Fixnum? It seems like
# an "in place" change could occur, keeping a reference to the same location, and modifying
# the value at that location. But somewhat surprisingly, that doesn't happen. If we multiply
# fl1, it becomes a reference to a new location, with a new value. fl5 and fl6 retains the
# reference to the original location and value. None of the others are affected since they
# referred to different objects to start with.

fl1 *= 2.5

puts ("\nAfter multiplying floats")
puts ("fl1: class = #{fl1.class}; value = #{fl1.inspect}; object_id = #{fl1.object_id}")
puts ("fl2: class = #{fl2.class}; value = #{fl2.inspect}; object_id = #{fl2.object_id}")
puts ("fl3: class = #{fl3.class}; value = #{fl3.inspect}; object_id = #{fl3.object_id}")
puts ("fl4: class = #{fl4.class}; value = #{fl4.inspect}; object_id = #{fl4.object_id}")
puts ("fl5: class = #{fl5.class}; value = #{fl5.inspect}; object_id = #{fl5.object_id}")
puts ("fl6: class = #{fl6.class}; value = #{fl6.inspect}; object_id = #{fl6.object_id}")


# Q6. Why would I use a Hash instead of an Array?

# They have a lot of the same capabilities, but a Hash is more flexible, because it
# can take any object type as the key, and arrays are limited to integer indexes.

a1 = Array.new(10, 0)
2.upto(6) do |index|
  a1[index] = (index + 1)
end
5.upto(8) do |index|
  a1[index] += (index + 1)
end
a1.each.with_index do |v, i|
  puts("a1[#{i}] = #{v}")
end
(8).upto(11) do |index|
  puts("a1[#{index}] = #{a1[index].inspect}")
end
puts ("Size of array: a1.size = #{a1.size}")

# Interesting that when the array expands, the new elements don't get the default
# value
puts ("Assigning new element a1[13] = \"fish\"")
a1[13] = "fish"
puts ("New size of array: a1.size = #{a1.size}")
(9).upto(14) do |index|
  puts("a1[#{index}] = #{a1[index].inspect}")
end


h1 = Hash.new("Not Found")
h2 = { :CT => "Connecticut", :NH => "New Hampshire",
  :VT => "Vermont", :MA => "Massachusetts",
  :ME => "Maine", :RI => "Rogue's Island" }

puts ("h1 starting value: #{h1.inspect}")
h2.each do |k,v|
  puts "Adding {#{k.inspect} => #{v}} to h1"
  h1[k] = v
end
puts ("h1 ending value: #{h1.inspect}")
puts ("Try a non-existent key: h1[:WA] = #{h1[:WA]}")

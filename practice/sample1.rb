# Q1: Three uses of curly braces

# 1. Hash initialization
hash1 = { :fish => "Wanda",
          :boy => "Sue",
          :streetcar => "Desire" }

puts hash1

# 2. Block delimiters, including creating Proc or lambda objects
hash1.each { |k, v| puts "A #{k.to_s} named #{'"' + v.to_s + '"'}" }

doubler = lambda { |p| puts "#{p}*2 = #{p*2}" }

puts "Object doubler is of class #{doubler.class}"
puts "doubler.inspect returns #{doubler.inspect}"

doubler.call 10
doubler.call "fish"
doubler.call ["zz", "yy", "xx"]
doubler.call [:a, :b]

# 3. Code evaluation within a String, as shown in the above examples

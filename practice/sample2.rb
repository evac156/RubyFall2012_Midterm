# Q2: Common uses of regular expressions

# Regexp defines a pattern of characters, including character literals, substring literals, classes of
# characters (whitespace, digits, letters, etc.), as well as repetitions, alternations ("match any one
# of several"), or exclusions of these.

regexp1 = /[Rr]uby/ # Match "Ruby" or "ruby"
regexp2 = /x+.*y+/ # Match any string with at least one x followed by at least one y
regexp3 = /([aeiou])\1/ # Match any vowel appearing twice in a row (lower-case only)
regexp4 = /^([A-Za-z0-9_]{1,50})(\.([a-z0-9]{1,3}))?$/ # Match a file name, up to 50 characters and an optional extension
regexp5 = /^(206|425|253)-(\d{3})-(\d{4})$/ # Match only a phone number with one of three area codes

# To determine whether a String contains a pattern: Can be done with the =~ operator, which simply returns
# the position where the pattern occurs, or nil if it is not found.

"We are studying Ruby" =~ regexp1
"We are also using Git" =~ regexp1

# Or can be done with the Regexp.match() method, which returns a MatchData object.

md1 = regexp2.match("This one has a y and then an x, so it won't match.")
md2 = regexp2.match("This has x and then xx and then yyy, so we expect a match.")

md3 = regexp4.match("Wild_Card77.txt")
md4 = regexp4.match("W_E_I_R_D_N_A_M_E")
md5 = regexp4.match("fix@this_name.rb")

# To replace that pattern within a string, can use the String.sub() and String.gsub() methods.

"This has x and then xx and then yyy, so we expect a match.".sub(regexp2, "the right letters").sub("match", "replacement")
"Three clean moons seen between four screen doors.".gsub(regexp3, "--")

"Wild_Card77.txt".sub(regexp4, 'Name: \1, Extension: \3')
"Wild_Card77.txt".match(regexp4) { |md| "Name: #{$1}; Extension: #{$3.upcase}" }

"W_E_I_R_D_N_A_M_E".sub(regexp4, 'Name: \1, Extension: \3')
"W_E_I_R_D_N_A_M_E".match(regexp4) { |md| "Name: #{$1}; Extension: #{$3.upcase}" }

"fix@this_name.rb".sub(regexp4, 'Name: \1, Extension: \3')
"fix@this_name.rb".match(regexp4) { |md| "Name: #{$1}; Extension: #{$3.upcase}" }

"206-331-6953".sub(regexp5, '\1-xxx-\3')
"425-772-8187".sub(regexp5, '\1-xxx-\3')

"206-331-6953".match(regexp5) { |md| "#{$1}-#{$2}-#{$3[0,2]}xx" }
"425-772-8187".match(regexp5) { |md| "#{$1}-#{$2}-#{$3[0,2]}xx" }

# Or we can use the MatchData again, to assign the data to variables:

phoneNums = ["206-331-6953", "425-772-8187", "253-867-5309"]
pnMap = Hash.new()
phoneNums.each do |pn|
  md = pn.match(regexp5)
  pnMap[pn] = md
  areaCode = md[1]
  exchange = md[2]
  line = md[3]
  puts("Area Code: #{areaCode}; Exchange: #{exchange}; Line: #{line}")
end
puts pnMap

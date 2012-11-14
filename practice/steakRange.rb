# The pickaxe, on p.90, mentions a range of "rare to well done," so I've tried to
# implement that here. It's easy enough to implement the .succ() and <=> operators
# to create a Range. However, there is a problem when trying to execute the
# .include?() method of the Range class. Since the Steak.new() method always
# returns a new object, we run into this:
#
# s0 = Steak.new 0 => Name: Moo!; Index: 0 
# s7 = Steak.new 7 => Name: Burnt!; Index: 7 
# r1 = (s0..s7) => Name: Moo!; Index: 0..Name: Burnt!; Index: 7 
# s2a = Steak.new 2 => Name: Rare; Index: 2 
# s2b = Steak.new 2 => Name: Rare; Index: 2 
# r1.include? s2a => true 
# r1.include? s2b => false 
# r1.cover? s2b => true 
#
# Because the first instance of any Steak value is cached for use in the .succ()
# and .prev() methods, it will be found by the .include?() method. But any subsequent
# instances will be distinct objects, and will not be found by .include?(), but
# will be found by .cover?()
#
# What we'd really like is a factory method, so that any time an instance is requested
# for a value, the same instance will be returned. But so far, I haven't figured out
# how to do that in Ruby.

class Steak

# Class constants for the names
@@D0 = "Moo!"
@@D1 = "Very Rare"
@@D2 = "Rare"
@@D3 = "Medium Rare"
@@D4 = "Medium"
@@D5 = "Medium Well"
@@D6 = "Well Done"
@@D7 = "Burnt!"

# Class constant array of the names, associating them with indices
@@DEGREES = [@@D0, @@D1, @@D2, @@D3, @@D4, @@D5, @@D6, @@D7]

# A class cache which will contain one instance of a Steak object for each name.
# By caching it, we won't have to create new instances every time .succ() or .prev()
# is called, and those methods will always return the same instance.
@@STEAK_CACHE = Hash.new

attr_reader :name, :index

# Take either the name or the index, and create a new Steak instance for it, if
# it is valid. If this is the first instance for the given value, cache it for
# later retrieval by the .succ() and .prev() methods
def initialize(p = 4)
  # If it's a string, look up the index from the name
  if ((p.is_a? String) && (@@DEGREES.index(p)))
    @index = @@DEGREES.index(p)
    @name = p
  # If it's an integer, look up the name from the index
  elsif ((p.is_a? Integer) && (p >= 0) && (p < @@DEGREES.size))
    @index = p
    @name = @@DEGREES[p]
  end
  @index.freeze
  @name.freeze

  # If this is a valid instance, cache it for later retrieval
  if (@index && !@@STEAK_CACHE[@index])
    @@STEAK_CACHE[@index] = self
  end
end

# Get the successor instance, based on the index of this instance
def succ
  ret = nil
  # If we're not the last valid value, look for the next one
  if (@index && (@index < (@@DEGREES.length - 1)))
    # Check the cache first for the successor
    if (@@STEAK_CACHE[@index + 1])
      ret = @@STEAK_CACHE[@index + 1]
    # If it wasn't in the cache, create and return a new instance
    else
      ret = Steak.new(@index + 1)
    end
  end
  ret
end

# Get the previous instance, based on the index of this instance
def prev
  ret = nil
  # If we're not the first valid value, look for the previous one
  if (@index && (@index > 0))
    # Check the cache first for the predecessor
    if (@@STEAK_CACHE[@index - 1])
      ret = @@STEAK_CACHE[@index - 1]
    # If it wasn't in the cache, create and return a new instance
    else
      ret = Steak.new(@index - 1)
    end
  end
  ret
end

# Just compare the two based on index
def <=>(otherSteak)
    @index <=> otherSteak.index
end

# Debug method: Dump out the contents of the class @@DEGREES array, for all
# values or for the specified index
def showDegrees(d = nil)
  if (d)
    puts("@@DEGREES[#{d}] = #{@@DEGREES[d]}, object_id = #{@@DEGREES[d].object_id}")
  else
    puts("@@DEGREES.object_id = #{@@DEGREES.object_id}")
    @@DEGREES.each.with_index do |deg, index|
      puts("@@DEGREES[#{index}] = #{deg}, object_id = #{deg.object_id}")
    end
  end
end

# Debug method: Dump out the contents of the class @@STEAK_CACHE hash, for all
# values or for the specified object
def showCache(s = nil)
  if (s.is_a? Steak)
    puts("@@STEAK_CACHE[#{s.index}] = #{@@STEAK_CACHE[s.index]}, object_id = #{@@STEAK_CACHE[s.index].object_id}")
  elsif (s.nil?)
    puts("@@STEAK_CACHE.object_id = #{@@STEAK_CACHE.object_id}")
    @@STEAK_CACHE.each do |k, v|
      puts("@@STEAK_CACHE[#{k}] = #{v}, object_id = #{v.object_id}")
    end
  else
    puts("Not a valid parameter. Pass me a steak, or nil.")
  end
end

# Return the name and index of the current Steak object
def to_s
  "Name: #@name; Index: #@index"
end

end

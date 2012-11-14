# A simple class for trying out ranges. A Square object contains the "base"
# value and the squared value. This class isn't very safe, because the user
# can pass non-integer values, which instantiates an object with {base = nil,
# square = nil}, and then comparisons aren't really valid.

class Square

attr_reader :base, :square

# If the constructor receives an integer, set the base and square, otherwise
# they are both nil
def initialize(base)
  if (base.is_a? Integer)
    @base = base
    @square = base * base
  end
  @base.freeze
  @square.freeze
end

# If this object has a valid base, then create a new Square with the base incremented
# by one. If this object does not have a valid base, its successor is nil
def succ
  if (@base)
    Square.new(@base + 1)
  else
    nil
  end
end

# If this object has a valid base, then create a new Square with the base decremented
# by one. If this object does not have a valid base, its predecessor is nil
def prev
  if (@base)
    Square.new(@base - 1)
  else
    nil
  end
end

# Compare two squares by their base, since (x)^2 = (-x)^2
def <=>(otherSquare)
  @base <=> otherSquare.base
end

def to_s
  "{#@base, #@square}"
end

end

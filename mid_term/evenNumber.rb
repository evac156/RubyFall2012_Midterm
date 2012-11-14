# A simple class for even numbers. Implements the succ and <=> operators so we
# can make a Range of EvenNumber objects.

class EvenNumber

  attr_reader :value

private
  def argErrFmt(p)
    "EvenNumber received #{p.inspect}; argument must be an even Integer"
  end

public
  # If the constructor receives an even integer, set the value. For anything other
  # than an even integer, throw an ArgumentError
  def initialize(newVal)
    if ((newVal.is_a? Integer) && (newVal.even?))
      @value = newVal
      @value.freeze
    else
      raise ArgumentError, argErrFmt(newVal)
    end
  end

  # Return the successor, which will be a new EvenNumber with the next higher value
  def succ
    if (@value)
      EvenNumber.new(@value + 2)
    else
      nil
    end
  end

  # Return the predecessor, which will be a new EvenNumber with the next lower value
  def prev
    if (@value)
      EvenNumber.new(@value - 2)
    else
      nil
    end
  end

  # Compare the two EvenNumber objects based on their value
  def <=>(otherEN)
    @value <=> otherEN.value
  end

  # Surprising that these have to be explicitly implemented; thought they would
  # just derive from <=>, but they don't. By doing this, we can get the expected
  # results for .include? in a Range.
  def >(otherEN)
    @value > otherEN.value
  end

  def <(otherEN)
    @value < otherEN.value
  end

  def ==(otherEN)
    @value == otherEN.value
  end

  # The string representation of this object is just its value
  def to_s
    @value.to_s
  end
end

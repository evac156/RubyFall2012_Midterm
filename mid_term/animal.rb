# Animal is a required superclass of Turkey

class Animal
  # Weight is applicable to any type of animal, so put it here, and let the
  # subclass inherit it
  attr_reader :weight

  def initialize(weight)
    @weight = weight
  end
end

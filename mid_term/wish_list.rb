# A WishList class for the midterm. It must:
# - Mixin Enumerable
# - Define each so it returns wishes as strings with their index as part of the string
#
# To use the Enumerable mix-in, we need to implement the .each iterator, and the
# elements of the collection must implement the <=> comparator.

class WishList
  include Enumerable

  attr_accessor :wishes

  def each
    @wishes.each.with_index do |w, i|
      yield ("#{i+1}. #{w}")
    end
  end
end


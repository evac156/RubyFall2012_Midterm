# Dinner is a required superclass of ThanksgivingDinner. Methods and properties
# which are applicable to any dinner go here, but when we subclass it as a
# ThanksgivingDinner, it'll get special values for those properties.

class Dinner
  # From the spec, we see that every dinner has:
  # - diet (passed into the initializer, an element of the menu hash)
  # - menu (a hash, which must have diet, proteins, and veggies, but not
  #     necessarily desserts)
  # - guests (who should NOT be a part of the menu)
  # - a seatingChartSize method (calculated from the guests)
  # - a whatsForDinner method (built from the menu)

  # Looks like we only need two public attributes. They are read-only here,
  # but are modifiable through other methods
  # guests is read-write
  attr_reader :menu
  attr_reader :guests

private
  # Ruby weirdness: We can't just set an instance variable in the class body, so
  # we have to have a method for it. Remember to call this from initialize().
  def initMembers
    # The menu is a hash, which always has :diet, :proteins, and :veggies
    @menu = { :diet => nil, :proteins => nil, :veggies => nil }
  end

public
  # When we instantiate, the diet is set
  def initialize(diet)
    initMembers
    @menu[:diet] = diet
    @guests = []
  end

  # Because we later need to be able to sum over the array of guests, we use this
  # setter method to enforce that guests will always be in an array. Use the
  # splat-n-flatten trick we learned in class.
  def guests=(*guests)
    @guests = guests.flatten
  end

  # Sum the letters in each guest name, using inject
  def seating_chart_size
    @guests.inject(0) { |sum, element| sum += element.to_s.length }
  end

  # Format the proteins and veggies according to the following rules:
  # - Start with phrase "Tonight we have"
  # - Proteins precede veggies (it's a hash, so we can't count on that by iterating)
  # -- Iterating over the hash would also get :diet and :desserts, which we don't want
  # - A comma separates the two groups
  # - Name of category precedes elements in category
  # - Name of category is not capitalized
  # - Elements of category are strings, no underscores, first letter capitalized
  # - For two elements, no commas; for three or more, commas after each except last
  # - "and" always precedes last element in group
  def whats_for_dinner
    "Tonight we have #{full_format_category(:proteins)}, and #{full_format_category(:veggies)}."
  end

protected
  # This one is an instance method, because it does depend on the state of the menu
  # object. Take any category (in this case, :proteins or :veggies), retrieve its
  # menu items, and format them together.
  def full_format_category(inCat)
    items = @menu[inCat]
    if (items && (items.size > 0))
      Dinner.format_category(inCat, items)
    else
      "a deplorable lack of #{inCat.to_s}"
    end
  end

  # Make this a utility class method also; it takes the category name and items
  # and formats them together. Because everything is passed in, it's not dependent
  # on object state.
  def Dinner.format_category(cat, items)
    "#{cat.to_s} #{Dinner.format_category_items(items)}"
  end

  # Make this a class method; it's just a utility formatter, not dependent on
  # object state. Takes the items in a category, formats each, and format them
  # as a single list.
  def Dinner.format_category_items(items)
    newItems = items.map { |item| Dinner.format_item(item) }
    Dinner.list_with_commas(newItems)
  end

  # Utility list formatter. If the collection is empty, the formatted list is
  # empty.  If it's just one item, it appears as-is. Two items just get a simple
  # "and" between them. Three or more, there is comma after each except the last,
  # and the "and" appears before the last.
  def Dinner.list_with_commas(items)
    itemCount = items.size
    # Very ugly way of doing it, but because of the specificity of the format,
    # requiring commas only if there are three or more items, we're kind of stuck
    # with this.
    case itemCount
    when 0
      formatted = ""
    when 1
      formatted = items[0]
    when 2
      formatted = ("#{items[0]} and #{items[1]}")
    else # 3 or more
      formatted = ""
      items.each.with_index do |item, index|
        formatted += item
        if (index != (itemCount - 1))
          formatted += ", "
          if (index == (itemCount - 2))
            formatted += "and "
          end
        end
      end
    end
    formatted
  end

  # Format any item from the collection. Convert it to a String, if it wasn't already;
  # replace underscores with spaces; convert to mixed case.
  def Dinner.format_item(item)
    s = item.to_s # in case we got a symbol
    s.gsub!('_', ' ')
    s.downcase.gsub(/\b\w/) { |first| first.upcase }
  end
end

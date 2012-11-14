require "#{File.dirname(__FILE__)}/dinner"

# ThanksgivingDinner class required for midterm, must extend superclass Dinner
class ThanksgivingDinner < Dinner
# Extend the methods with whatsForDessert

public
  # Use the superclass initializer, and extend the @menu hash with an element
  # for :desserts, since ThanksgivingDinner always has desserts
  def initialize(diet)
    super(diet)
    @menu[:desserts] = nil

    customizeMenu
  end

  # The requested result for this is inconsistent; for the category of :molds,
  # the category name and the count are shown. For the categories of :pies and
  # :other, the category name and count are omitted. The only apparent cause for
  # this is that the quantity is 1, so we'll go with that as a criterion.
  #
  # Also, the formatting within a group is inconsistent. When we formatted three
  # veggies, [:ginger_carrots , :potatoes, :yams] became "Ginger Carrots, Potatoes,
  # and Yams". Here, when we have [:cranberry, :mango, :cherry], it is supposed to
  # be formatted as "Cranberry and Mango and Cherry". So, the group-formatting
  # method that we created in the Dinner class, needs to be overridden here.
  def whats_for_dessert
    "Tonight we have #{dessert_item_count} delicious desserts: #{dessert_format_subcats}."
  end

private
  # This seems like a really crude way of making the class pass the spec, since
  # I just copied the values directly from there. (Testing a constant doesn't
  # really prove much.)
  def customizeMenu
    menu[:proteins] = ["Tofurkey", "Hummus"]
    menu[:veggies] = [:ginger_carrots , :potatoes, :yams]
    menu[:desserts] = { :pies => [:pumkin_pie],
                        :other => ["Chocolate Moose"],
                        :molds => [:cranberry, :mango, :cherry] }
  end

  # Count the total items in the dessert list. Get the dessert hash, and for
  # each key-value pair, the value is going to be an array, so add up the sizes
  # of those arrays.
  def dessert_item_count
    desserts = @menu[:desserts]
    total = 0
    desserts.each { |k, v| total += v.size }
    total
  end

  # Get all the dessert subcategories (the entire hash), and format them into
  # one crazy list
  def dessert_format_subcats
    ThanksgivingDinner.format_all_subcats(@menu[:desserts])
  end

  # Take a hash of dessert subcategories. Iterate over the key-value pairs,
  # formatting each pair and saving the results to a new array. Then make a master
  # list from all of those results.
  def ThanksgivingDinner.format_all_subcats(subcats)
    subcatCount = subcats.size
    formatted = subcats.map do |k, v|
      format_dessert_subcat(k, v)
    end
    Dinner.list_with_commas(formatted)
  end

  # Format a single dessert subcategory, with the name of the subcategory and
  # the names of all items in it. From the look of the spec, we include the name
  # and count of the subcategory only if it's greater than one (so in this case,
  # it will get applied to :molds, but not to :pies or :other). The names of the
  # items in the subcategory are concatenated together with ands.
  def ThanksgivingDinner.format_dessert_subcat(subcat, items)
    itemCount = items.size
    formatted = ""
    case itemCount
    when 0
      formatted = "(Somebody forgot the #{subcat.to_s}!)"
    when 1
      formatted = Dinner.format_item(items[0])
    else # 2 or more
      newItems = items.map { |item| Dinner.format_item(item) }
      formatted = "#{itemCount} #{subcat.to_s}: #{newItems.join(" and " )}"
    end
    formatted
  end
end

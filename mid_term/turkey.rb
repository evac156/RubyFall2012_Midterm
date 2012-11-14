require "#{File.dirname(__FILE__)}/animal"

# Turkey class required for midterm, must extend superclass Animal
class Turkey < Animal

private
  @@MAIN_WORD_PAT = /((\w+\'\w+)|(\w+))/
  @@STARTS_WITH_G = /^([Gg]).*$/

  # Take a string that starts with a letter, and change that first letter to
  # a 'G' or 'g', in the same case as the original first letter. If we get a
  # string that doesn't start with a letter, it'll be returned unchanged; that
  # may or may not be correct, the spec didn't cover that example.
  def firstToG(s)
    s.sub(/^[A-Z](.*)$/, 'G\1').sub(/^[a-z](.*)$/, 'g\1')
  end

public
  # A uniquely turkey-ish method, so implement it here in the subclass
  #
  # Can tell the following from the rspec:
  # - Each word is replaced by a variant of "gobble"
  # - First-letter case is preserved
  # - Punctuation external to words is preserved
  # -- Not clear how "Don't" maps to "Gobb'le"; doesn't look like it's by position
  #    of the apostrophe within the word
  # -- Making the assumption that any word with an apostrophe inside it is
  #    replaced by the same substring
  def gobble_speak(phrase)
    # Match a block of word characters with or without an apostrophe. Since the
    # Pattern with the apostrophe is first, it's preferred. (Surprising!)
    phrase.gsub(@@MAIN_WORD_PAT) do
      # Change the first letter of the matched block to a 'G' or 'g'
      tmp = firstToG($1)
      # See whether we need to insert an apostrophe, if it was matched originally
      breaker = (if $2 then "'" else "" end)
      # Keep just the initial 'G' or 'g', and replace the rest of the word
      final = tmp.sub(@@STARTS_WITH_G) { "#{$1}obb#{breaker}le" }
    end
  end
end

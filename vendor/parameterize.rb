# File activesupport/lib/active_support/inflector/transliterate.rb, line 80
def parameterize(string, sep = '-')
  # replace accented chars with their ascii equivalents
  parameterized_string = string.dup.downcase
  # Turn unwanted chars into the separator
  parameterized_string.gsub!(/[^a-z0-9\-_]+/, sep)
  unless sep.nil? || sep.empty?
    re_sep = Regexp.escape(sep)
    # No more than one of the separator in a row.
    parameterized_string.gsub!(/#{re_sep}{2,}/, sep)
    # Remove leading/trailing separator.
    parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/, '')
  end
  parameterized_string
end
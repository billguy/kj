require_relative 'kj/book'
require_relative 'kj/chapter'
require_relative 'kj/verse'

module Kj

  class Bible

    def book(name_or_number)
      Book.from_name_or_number(name_or_number)
    end

    def books(*names_or_numbers)
      names_or_numbers.empty? ? Book.all : Book.from_names_or_numbers(names_or_numbers)
    end

    def random_book
      Book.random
    end

    def random_chapter
      Chapter.random
    end

    def random_verse
      Verse.random
    end

    def at(percent)
      Verse.at(percent)
    end

  end

end
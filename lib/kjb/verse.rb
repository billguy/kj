require 'kjb/verse'

module Kjb

  class Verse < Base

    attr_reader :book, :chapter, :number

    def initialize(book, chapter, number)
      super
      @book = book
      @chapter = chapter
      @number = number
    end

    def to_s
      # text
    end

  end

end
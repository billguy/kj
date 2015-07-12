require 'kjb/verse'

module Kjb

  class Chapter < Base

    attr_reader :book, :number

    def initialize(book, number)
      super
      @book = book
      @number = number
    end

    def to_s

    end

    def verse(number)
      Kjb::Verse.new(@book, self, number)
    end

  end

end
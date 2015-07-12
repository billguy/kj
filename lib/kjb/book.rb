require 'kjb/chapter'

module Kjb

  class Book < Base

    attr_reader :bible, :name

    def initialize(bible, name)
      super
      @bible = bible
      @name = normalize_book_name(name) or raise "Called with incorrect book"
    end

    def to_s

    end

    def chapter(number)
      Kjb::Chapter.new(self, number)
    end

    private

      def normalize_book_name(name)

      end

  end

end
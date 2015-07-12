require "sqlite3"
require_relative 'kjb/db'
# require 'kjb/book'

module Kj

  class Bible
    def book(name)
      Kjb::Book.new(self, name)
    end

    def books
      Kjb::Db.query("SELECT * FROM books") do |results|
        results.map{|book| book['name']}
      end
    end

  end

end
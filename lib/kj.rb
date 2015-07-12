require "sqlite3"
require 'kj/db'
require 'kj/book'

module Kj

  class Bible

    def book(name_or_number)
      if name_or_number.is_a?(Integer)
        book = Db.query("SELECT id, name FROM books WHERE id = ?", [name_or_number], true)
      else
        book = Db.query("SELECT id, name FROM books WHERE name = ? OR abbreviations LIKE ?", [name_or_number.to_s.downcase, "%#{name_or_number.to_s}%"], true)
      end
      Book.new(id: book['id'], name: book['name'])
    end

    def books(*names_or_numbers)
      if names_or_numbers.empty?
        @books = begin
          results = Db.query("SELECT id, name FROM books")
          results.map{ |book| Book.new(id: book['id'], name: book['name']) }
        end
      else
        names_or_numbers.flatten!
        numbers = names_or_numbers.uniq.select{|n| n.is_a?(Integer)}
        names = (names_or_numbers - numbers).uniq.map{|name| name.to_s.downcase}
        results = []
        results << Db.query("SELECT id, name FROM books WHERE id IN (#{numbers.join(',')})") if numbers.any?
        names.each{ |name| results << Db.query("SELECT id, name FROM books WHERE abbreviations LIKE ?", ["%#{name.to_s}%"]) }
        results.flatten.map!{|book| Book.new(id: book['id'], name: book['name'])}.uniq.sort!{ |a,b| a.id <=> b.id }
      end
    end

  end

end
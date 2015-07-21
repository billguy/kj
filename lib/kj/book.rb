module Kj

  class Book < Base

    attr_accessor :id, :name

    def initialize(args)
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def title
      name
    end

    def to_s
      name
    end

    def self.from_name_or_number(name_or_number)
      if name_or_number.is_a?(Integer)
        book = Db.query("SELECT id, name FROM books WHERE id = ?", [name_or_number], true)
      else
        book = Db.query("SELECT id, name FROM books WHERE name = ? OR abbreviations LIKE ?", [name_or_number.to_s.downcase, "%#{name_or_number.to_s}%"], true)
      end
      new(id: book['id'], name: book['name'])
    end

    def self.from_names_or_numbers(names_or_numbers)
      names_or_numbers.flatten!
      numbers = names_or_numbers.uniq.select{|n| n.is_a?(Integer)}
      names = (names_or_numbers - numbers).uniq.map{|name| name.to_s.downcase}
      results = []
      results << Db.query("SELECT id, name FROM books WHERE id IN (#{numbers.join(',')})") if numbers.any?
      names.each{ |name| results << Db.query("SELECT id, name FROM books WHERE abbreviations LIKE ?", ["%#{name.to_s}%"]) }
      results.flatten.map!{|book| new(id: book['id'], name: book['name'])}.uniq.sort!{ |a,b| a.id <=> b.id }
    end

    def self.all
      @all ||= begin
        books = Db.query("SELECT id, name FROM books")
        books.map{ |book| new(id: book['id'], name: book['name']) }
      end
    end

    def self.count
      66
    end

    def self.random
      from_name_or_number(rand(1..count))
    end

    def chapter(number)
      chapter = Db.query("SELECT id FROM chapters WHERE book_id = ? AND number = ?", [@id, number], true)
      Chapter.new(id: chapter['id'], book: self, number: number)
    end

    def chapters(*numbers)
      if numbers.empty?
        @chapters ||= begin
          results = Db.query("SELECT id, number FROM chapters WHERE book_id = ?", [@id])
          results.map{|chapter| Chapter.new(id: chapter['id'], book: self, number: chapter['number'])}
        end
      else
        results = Db.query("SELECT id, number FROM chapters WHERE book_id = #{@id} AND number IN (#{numbers.flatten.join(',')})")
        results.map{|chapter| Chapter.new(id: chapter['id'], book: self, number: chapter['number'])}.sort!{ |a,b| a.id <=> b.id }
      end
    end

  end

end
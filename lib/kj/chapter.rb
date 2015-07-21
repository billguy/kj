module Kj

  class Chapter < Base

    attr_accessor :id, :book_id, :number
    attr_writer :book

    def initialize(args)
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def title
      "#{book_name} #{number}"
    end

    def book
      @book ||= begin
        b = Db.query("SELECT id, name FROM books WHERE id = ?", [@book_id], true)
        Book.new(id: b['id'], name: b['name'])
      end
    end

    def book_name
      book.name
    end

    def to_s
      title
    end

    def self.count
      1184
    end

    def self.random
      chapter = Db.query("SELECT id, book_id, number FROM chapters WHERE id = ?", [rand(1..count)], true)
      new(id: chapter['id'], book_id: chapter['book_id'], number: chapter['number'])
    end

    def verse(verse_number)
      verse = Db.query("SELECT id FROM verses WHERE chapter_id = ? AND number = ?", [@id, verse_number], true)
      Verse.new(id: verse['id'], book_name: book_name, chapter: self, number: verse_number)
    end

    def verses(*numbers)
      if numbers.empty?
        @verses ||= begin
          results = Db.query("SELECT id, number FROM verses WHERE chapter_id = ?", [@id])
          results.map{|verse| Verse.new(id: verse['id'], book_name: book_name, chapter: self, number: verse['number'])}
        end
      else
        results = Db.query("SELECT id, number FROM verses WHERE chapter_id = #{@id} AND number IN (#{numbers.flatten.join(',')})")
        results.map!{|verse| Verse.new(id: verse['id'], book_name: book_name, chapter: self, number: verse['number'])}.sort!{ |a,b| a.id <=> b.id }
      end
    end

  end

end
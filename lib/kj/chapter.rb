require_relative 'base'

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
        b = Db.query("SELECT id, name, permalink FROM books WHERE id = ?", [book_id], true)
        Book.new(id: b['id'], name: b['name'], permalink: b['permalink'])
      end
    end

    def book_name
      book.name
    end

    def book_permalink
      book.permalink
    end

    def to_s
      title
    end

    def next
      @next ||= begin
        c = Db.query("SELECT id, book_id, number FROM chapters WHERE id = ?", [id + 1], true)
        self.class.new(id: c['id'], book_id: c['book_id'], number: c['number'])
        rescue Kj::Iniquity
          c = Db.query("SELECT id, book_id, number FROM chapters WHERE id = ?", [1], true)
          self.class.new(id: c['id'], book_id: c['book_id'], number: c['number'])
      end
    end

    def prev
      @prev ||= begin
        c = Db.query("SELECT id, book_id, number FROM chapters WHERE id = ?", [id - 1], true)
        self.class.new(id: c['id'], book_id: c['book_id'], number: c['number'])
        rescue Kj::Iniquity
          c = Db.query("SELECT id, book_id, number FROM chapters WHERE id = ?", [self.class.count], true)
          self.class.new(id: c['id'], book_id: c['book_id'], number: c['number'])
      end
    end

    def self.count
      1189
    end

    def self.random
      chapter = Db.query("SELECT id, book_id, number FROM chapters WHERE id = ?", [rand(1..count)], true)
      new(id: chapter['id'], book_id: chapter['book_id'], number: chapter['number'])
    end

    def verse(verse_number)
      verse = Db.query("SELECT id FROM verses WHERE chapter_id = ? AND number = ?", [id, verse_number], true)
      Verse.new(id: verse['id'], book_name: book_name, chapter_id: id, number: verse_number)
    end

    def verses(*numbers)
      if numbers.empty?
        @verses ||= begin
          results = Db.query("SELECT id, number, page FROM verses WHERE chapter_id = ?", [id])
          results.map{|verse| Verse.new(id: verse['id'], book_name: book_name, chapter_id: id, number: verse['number'], page: verse['page'])}
        end
      else
        results = Db.query("SELECT id, number, page FROM verses WHERE chapter_id = #{id} AND number IN (#{numbers.flatten.join(',')})")
        results.map!{|verse| Verse.new(id: verse['id'], book_name: book_name, chapter_id: id, number: verse['number'], page: verse['page'])}.sort!{ |a,b| a.id <=> b.id }
      end
    end

  end

end
require_relative 'base'

module Kj

  class Verse < Base

    attr_accessor :id, :chapter_id, :number
    attr_writer :chapter

    def initialize(args)
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def title
      "#{book_name} #{chapter_number}:#{number}"
    end

    def self.count
      31102
    end

    def self.random
      verse = Db.query("SELECT id, chapter_id, number, page FROM verses WHERE id = ?", [rand(1..count)], true)
      new(id: verse['id'], chapter_id: verse['chapter_id'], number: verse['number'], page: verse['page'])
    end

    def self.percent(decimal)
      if decimal.round(3) <= 0
        verse_id = 1
      elsif decimal.round(3) >= 1
        verse_id = count
      else
        verse_id = (count * decimal).round
      end
      verse = Db.query("SELECT id, chapter_id, number, page FROM verses WHERE id = ?", [verse_id], true)
      new(id: verse['id'], chapter_id: verse['chapter_id'], number: verse['number'], page: verse['page'])
    end

    def self.page_count
      1609
    end

    def self.page(page)
      verses = Db.query("SELECT id, chapter_id, number, page FROM verses WHERE page = ?", [page])
      verses.map{|verse| new(id: verse['id'], chapter_id: verse['chapter_id'], number: verse['number'], page: verse['page'])}
    end

    def chapter
      @chapter ||= begin
        c = Db.query("SELECT id, book_id, number FROM chapters WHERE id = ?", [chapter_id], true)
        Chapter.new(id: c['id'], book_id: c['book_id'], number: c['number'])
      end
    end

    def chapter_number
      chapter.number
    end

    def book_name
      chapter.book_name
    end

    def book_permalink
      chapter.book_permalink
    end

    def to_s
      text
    end

    def next
      @next ||= begin
        v = Db.query("SELECT id, chapter_id, text, number, page FROM verses WHERE id = ?", [id +  1], true)
        self.class.new(id: v['id'], chapter_id: v['chapter_id'], text: v['text'], number: v['number'], page: v['page'])
        rescue Kj::Iniquity
          v = Db.query("SELECT id, chapter_id, text, number, page FROM verses WHERE id = ?", [1], true)
          self.class.new(id: v['id'], chapter_id: v['chapter_id'], text: v['text'], number: v['number'], page: v['page'])
      end
    end

    def prev
      @prev ||= begin
        v = Db.query("SELECT id, chapter_id, text, number, page FROM verses WHERE id = ?", [id - 1], true)
        self.class.new(id: v['id'], chapter_id: v['chapter_id'], text: v['text'], number: v['number'], page: v['page'])
        rescue Kj::Iniquity
          v = Db.query("SELECT id, chapter_id, text, number, page FROM verses WHERE id = ?", [self.class.count], true)
          self.class.new(id: v['id'], chapter_id: v['chapter_id'], text: v['text'], number: v['number'], page: v['page'])
      end
    end

    def text
      @text ||= begin
        verse = Db.query("SELECT text FROM verses WHERE id = ?", [id], true)
        verse['text']
      end
    end

    def page
      @page ||= begin
        verse = Db.query("SELECT page FROM verses WHERE id = ?", [id], true)
        verse['page']
      end
    end

  end

end
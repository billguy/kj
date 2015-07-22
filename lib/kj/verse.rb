module Kj

  class Verse

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
      verse = Db.query("SELECT id, chapter_id, number FROM verses WHERE id = ?", [rand(1..count)], true)
      new(id: verse['id'], chapter_id: verse['chapter_id'], number: verse['number'])
    end

    def chapter
      @chapter ||= begin
        c = Db.query("SELECT id, book_id, number FROM chapters WHERE id = ?", [@chapter_id], true)
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
        v = Db.query("SELECT id, chapter_id, text, number FROM verses WHERE id > ? order by id asc limit 1", [@id], true)
        self.class.new(id: v['id'], chapter_id: v['chapter_id'], text: v['text'], number: v['number'])
        rescue Kj::Iniquity
          v = Db.query("SELECT id, chapter_id, text, number FROM verses WHERE id = ?", [1], true)
          self.class.new(id: v['id'], chapter_id: v['chapter_id'], text: v['text'], number: v['number'])
      end
    end

    def prev
      @prev ||= begin
        v = Db.query("SELECT id, chapter_id, text, number FROM verses WHERE id < ? order by id desc limit 1", [@id], true)
        self.class.new(id: v['id'], chapter_id: v['chapter_id'], text: v['text'], number: v['number'])
        rescue Kj::Iniquity
          v = Db.query("SELECT id, chapter_id, text, number FROM verses WHERE id = ?", [self.class.count], true)
          self.class.new(id: v['id'], chapter_id: v['chapter_id'], text: v['text'], number: v['number'])
      end
    end

    def text
      @text ||= begin
        verse = Db.query("SELECT chapter_id, text FROM verses WHERE id = ?", [@id], true)
        verse['text']
      end
    end

  end

end
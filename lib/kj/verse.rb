module Kj

  class Verse

    attr_reader :id, :book_name, :chapter_id, :chapter_number, :number

    def initialize(args)
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def title
      "#{book_name} #{chapter_number}:#{number}"
    end

    def to_s
      text
    end

    def text
      @text ||= begin
        verse = Db.query("SELECT chapter_id, text FROM verses WHERE id = ?", [@id], true)
        verse['text']
      end
    end

  end

end
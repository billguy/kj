require_relative 'verse'

module Kj

  class Chapter

    attr_reader :id, :book_id, :book_name, :number

    def initialize(args)
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    def title
      "#{book_name} #{number}"
    end

    def to_s
      title
    end

    def verse(verse_number)
      verse = Db.query("SELECT id FROM verses WHERE chapter_id = ? AND number = ?", [@id, verse_number], true)
      Verse.new(id: verse['id'], book_name: book_name, chapter_id: @id, chapter_number: @number, number: verse_number)
    end

    def verses(*numbers)
      if numbers.empty?
        @verses ||= begin
          results = Db.query("SELECT id, number FROM verses WHERE chapter_id = ?", [@id])
          results.map{|verse| Verse.new(id: verse['id'], book_name: book_name, chapter_id: @id, chapter_number: number, number: verse['number'])}
        end
      else
        results = Db.query("SELECT id, number FROM verses WHERE chapter_id = #{@id} AND number IN (#{numbers.flatten.join(',')})")
        results.map!{|verse| Verse.new(id: verse['id'], book_name: book_name, chapter_id: @id, chapter_number: number, number: verse['number'])}.sort!{ |a,b| a.id <=> b.id }
      end
    end

  end

end
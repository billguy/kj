require_relative 'chapter'

module Kj

  class Book

    attr_reader :id, :name

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

    def chapter(number)
      chapter = Db.query("SELECT id FROM chapters WHERE book_id = ? AND number = ?", [@id, number], true)
      Chapter.new(id: chapter['id'], book_id: @id, book_name: name, number: number)
    end

    def chapters(*numbers)
      if numbers.empty?
        @chapters ||= begin
          results = Db.query("SELECT id, number FROM chapters WHERE book_id = ?", [@id])
          results.map{|chapter| Chapter.new(id: chapter['id'], book_id: @id, book_name: name, number: chapter['number'])}
        end
      else
        results = Db.query("SELECT id, number FROM chapters WHERE book_id = #{@id} AND number IN (#{numbers.flatten.join(',')})")
        results.map{|chapter| Chapter.new(id: chapter['id'], book_id: @id, book_name: name, number: chapter['number'])}.sort!{ |a,b| a.id <=> b.id }
      end
    end

  end

end
require "sqlite3"
require "pathname"
require_relative 'exceptions'

module Kj
  class Db
    def self.db
      @db ||= begin
        path = Pathname(File.absolute_path(__FILE__))
        SQLite3::Database.new(File.join(path.parent.parent.parent.to_s, 'db/kjb.db'))
      end
    end

    def self.select(params={table_name: nil, fields: [], conditions: {}, return_first_record: false, operator: 'AND'})
      sql = "SELECT %s FROM %s WHERE %s" % [params[:fields].join(','), params[:table_name], params[:conditions].keys.map{|key| "#{key} = ?"}.join(" #{params[:operator]} ")]
      query(sql, params[:conditions].values, params[:limit] == 1)
    end

    def self.query(sql, values=[], return_first_record=false)
      db.results_as_hash = true
      sql.gsub!(/^.{6}/, 'SELECT')
      if return_first_record
        result = db.get_first_row(sql, values)
        result.nil? ? raise(Iniquity, "Not found") : result
      else
        db.execute(sql, values)
      end
      rescue SQLite3::RangeException
        raise Iniquity, "Query out of range"
    end

  end
end
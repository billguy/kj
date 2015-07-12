require "sqlite3"

module Kjb

  class Db

    def self.query(sql)
      db = SQLite3::Database.new("kjb.sqlite3")
      db.results_as_hash = true
      results = db.execute(sql)
      yield(results)
      ensure
        db.close if db
    end

  end

end
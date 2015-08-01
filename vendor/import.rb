require 'csv'
require "sqlite3"
require "pathname"

path = Pathname(File.absolute_path(__FILE__))
db = SQLite3::Database.new(File.join(path.parent.parent.to_s, 'db/kjb.db'))
db.results_as_hash = true
db.execute "Delete from books"
db.execute "Delete from chapters"
db.execute "Delete from verses"
db.execute "DELETE FROM SQLITE_SEQUENCE WHERE name='books' OR name='chapters' OR name='verses'"
csv_text = File.read(File.join(path.parent.to_s, 'books.csv'))
csv = CSV.parse(csv_text)
csv.each do |row| # build books table
  book_name = row[0]
  permalink = book_name.downcase.gsub(/[^a-z0-9\-_]+/, '-')
  abbreviations = row[1].split(',').map{|abb| abb.downcase.gsub(' ', '')}
  abbreviations << book_name.downcase
  abbreviations.uniq!
  db.execute("INSERT INTO books(name, abbreviations, permalink) VALUES (?, ?, ?)", [book_name, abbreviations.join(','), permalink])
end

current_book_id, current_book_name, current_chapter_id, current_chapter_number = nil, nil, nil, nil # import chapters, verses
File.readlines(File.join(path.parent.to_s, 'kjb.txt')).each do |line| #obtained from https://getbible.net/Bibles
  parts = line.split('||')
  book_name = parts[0]
  chapter_number = parts[1].to_i
  verse_number = parts[2].to_i
  verse_text = parts[3].chomp
  if current_book_name != book_name
    current_book_name = book_name
    current_chapter_number = nil
    current_book_id = db.get_first_row("SELECT id FROM books WHERE name = ?", [book_name])['id']
  end
  if current_chapter_number != chapter_number
    current_chapter_number = chapter_number
    db.execute("INSERT INTO chapters(number, book_id) VALUES (?, ?)", [chapter_number, current_book_id])
    current_chapter_id = db.last_insert_row_id
  end
  db.execute("INSERT INTO verses(text, number, chapter_id) VALUES (?, ?, ?)", [verse_text, verse_number, current_chapter_id])
end

db.close
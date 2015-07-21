# kj
kj is a simple rubygem for accessing the King James Bible.  It uses an embedded sqlite data store.

___
### Install
```ruby
gem install kj
```
## Usage
### Create
```ruby
require 'kj'
bible = Kj::Bible.new
```
### Books
All return an array of Book objects.
```ruby
books = bible.books 
books = bible.books(1) 
books = bible.books(:genesis)
books = bible.books('Gen')
books = bible.books(:genesis, 2, 'Levit')
```
### Book
```ruby
romans = bible.book(45)
romans = bible.book(:romans)
romans = bible.book('Rom')
puts romans.name
 => "Romans" 
```
### Chapters
All return an array of Chapter objects for the book.
```ruby
genesis = bible.book(:genesis)
chapters = genesis.chapters 
chapters = genesis.chapters(1, 2, (3..10).to_a)
```
### Chapter
```ruby
genesis = bible.book(:genesis)
chapter = genesis.chapter(1)
puts chapter.book_name
 => "Genesis" 
puts chapter.number
 => 1
puts chapter.title
 => "Genesis 1"
```
### Verses
All return an array of Verse objects.
```ruby
genesis = bible.book(:genesis)
verses = genesis.chapter(1).verses
verse = genesis.chapter(1).verses(1, 2, (3..10).to_a)
```
### Verse
```ruby
genesis = bible.book(:genesis)
verse = genesis.chapter(1).verse(1)
puts verse.title
 => "Genesis 1:1" 
puts verse.text
 => "In the beginning God..."
```
### Random
```ruby
bible.random_book #returns a random Kj::Book
bible.random_chapter #returns a random Kj::Chapter
bible.random_verse #returns a random Kj::Verse
puts bible.random_verse.text
 => "But woe unto you, scribes and Pharisees, hypocrites! for ye shut up the kingdom of heaven against men: for ye neither go in yourselves, neither suffer ye them that are entering to go in."
```
### Exceptions
Kj will raise a Kj::Iniquity when it can't find what you're looking for.  
```
bible.book(:tobit)
# Kj::Iniquity: Not found
```
As you can see, kj is a protestant gem.
### FAQ
Q. Why only King James?  Are you one of those 'King James only' nuts?

A. Yes 

### Contributing to kj
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Copyright

Copyright (c) 2015 David John. See LICENSE.txt for
further details.


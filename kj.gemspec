# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: kj 0.0.13 ruby lib

Gem::Specification.new do |s|
  s.name = "kj"
  s.version = "0.0.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["David John"]
  s.date = "2015-08-09"
  s.description = "kj is a simple rubygem for accessing the King James Bible.  It uses an embedded sqlite data store."
  s.email = "djohn@arch-no.org"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "db/kjb.db",
    "kj.gemspec",
    "lib/kj.rb",
    "lib/kj/base.rb",
    "lib/kj/book.rb",
    "lib/kj/chapter.rb",
    "lib/kj/db.rb",
    "lib/kj/exceptions.rb",
    "lib/kj/verse.rb",
    "spec/book_spec.rb",
    "spec/chapter_spec.rb",
    "spec/kj_spec.rb",
    "spec/spec_helper.rb",
    "spec/verse_spec.rb",
    "vendor/README.md",
    "vendor/books.csv",
    "vendor/import.rb"
  ]
  s.homepage = "http://github.com/billguy/kj"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "kj is a simple rubygem for accessing the King James Bible"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sqlite3>, ["~> 1.3"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
    else
      s.add_dependency(%q<sqlite3>, ["~> 1.3"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<sqlite3>, ["~> 1.3"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
  end
end


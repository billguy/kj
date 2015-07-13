require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Kj" do

  describe "Verse" do

    let(:bible) { Kj::Bible.new }
    let(:book) { bible.book(:genesis) }
    let(:chapter) { book.chapter(1) }
    let(:verse) { chapter.verse(1) }

    it '#title' do
      expect(verse.title).to eq("Genesis 1:1")
    end

    describe '#text' do
      it 'returns the verse text' do
        expect(bible.book(:gen).chapter(1).verse(1).text).to eq("In the beginning God created the heaven and the earth." )
        expect(bible.book(:gen).chapter(1).verse(2).text).to_not eq("In the beginning God created the heaven and the earth." )
      end
    end

  end

end
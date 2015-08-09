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

    it '#book_permalink' do
      expect(verse.book_permalink).to eq(book.permalink)
    end

    describe '#prev' do
      it 'returns the previous Verse' do
        expect(verse.prev.number).to eq(21) # Rev 22:21
      end
    end

    describe '#next' do
      it 'returns the next Verse' do
        expect(verse.next.number).to eq(2)
      end
    end

    describe '.percent' do
      it 'returns gen 1:1 when given <=0' do
        expect(Kj::Verse.percent(0).id).to eq(1)
      end
      it 'returns rev 22:21 when given >=1' do
        expect(Kj::Verse.percent(1).id).to eq(Kj::Verse.count)
      end
      it 'returns the correct verse' do
        expect(Kj::Verse.percent(0.5).id).to eq(15551)
      end
    end

  end

end
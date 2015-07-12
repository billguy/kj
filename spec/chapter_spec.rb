require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Kj" do

  describe "Chapter" do

    let(:bible) { Kj::Bible.new }
    let(:book) { bible.book(:genesis) }
    let(:chapter) { book.chapter(1) }

    it '#title' do
      expect(chapter.title).to eq("Genesis 1")
    end

    describe '#verses' do
      it 'returns an array' do
        expect(chapter.verses).to be_kind_of(Array)
        expect(chapter.verses(1, 2, (3..10).to_a)).to be_kind_of(Array)
      end
    end

    describe '#verse' do
      it 'returns a Verse' do
        expect(chapter.verse(1)).to be_kind_of(Kj::Verse)
      end
    end

  end

end
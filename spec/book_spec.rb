require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Kj" do

  describe "Book" do

    let(:bible) { Kj::Bible.new }
    let(:book) { bible.book(:genesis) }

    it '#title' do
      expect(book.title).to eq("Genesis")
    end

    describe '#chapters' do
      it 'returns an array' do
        expect(book.chapters).to be_kind_of(Array)
        expect(book.chapters(1, 2, (3..10).to_a)).to be_kind_of(Array)
      end
    end

    describe '#chapter' do
      it 'returns a Chapter' do
        expect(book.chapter(1)).to be_kind_of(Kj::Chapter)
      end
    end

  end

end
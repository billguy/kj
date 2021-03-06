require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Kj" do

  describe "Bible" do

    let(:bible) { Kj::Bible.new }

    it 'returns an instance of Kj::Bible' do
      expect(bible).to be_kind_of(Kj::Bible)
    end

    describe "#books" do
      it 'returns an array' do
        expect(bible.books).to be_kind_of(Array)
        expect(bible.books(1, 2, (3..10).to_a)).to be_kind_of(Array)
      end
    end

    describe "#book" do
      it 'returns a Book' do
        expect(bible.book(:genesis)).to be_kind_of(Kj::Book)
      end
    end

    describe "#random_book" do
      it 'returns a Book' do
        expect(bible.random_book).to be_kind_of(Kj::Book)
      end
    end

    describe "#random_chapter" do
      it 'returns a Chapter' do
        expect(bible.random_chapter).to be_kind_of(Kj::Chapter)
      end
    end

    describe "#random_verse" do
      it 'returns a Verse' do
        expect(bible.random_verse).to be_kind_of(Kj::Verse)
      end
    end
  end

end
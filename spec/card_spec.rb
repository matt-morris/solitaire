require 'card'

RSpec.describe Card do
  describe 'face' do
    it 'starts face down' do
      expect(Card.new.face_up?).to be(false)
    end

    it 'is flippable' do
      card = Card.new(1, :Spades)
      face_up = card.face_up?
      expect(card.flip.face_up?).to_not eq(face_up)
    end
  end

  describe 'value' do
    it 'has a default rank' do
      expect(Card.new.rank).to be(:A)
    end

    it 'has a default suit' do
      expect(Card.new.suit).to be(:Spades)
    end

    it 'can be initialized with a rank' do
      expect(Card.new(2).rank).to be(2)
    end

    it 'can be initialized with a suit' do
      expect(Card.new(2, :Hearts).suit).to be(:Hearts)
    end
  end

  describe 'color' do
    it 'can be black' do
      expect(Card.new.black?).to be(true)
    end

    it 'can be red' do
      expect(Card.new(1, :Hearts).red?).to be(true)
    end

    it 'is not both red and black' do
      card = Card.new
      expect(card.black?).to be(true) and expect(card.red?).to be(false)
    end
  end
end

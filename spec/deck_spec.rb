require 'deck'

RSpec.describe Deck do
  it 'has 52 cards' do
    expect(Deck.new.size).to be(52)
  end
end

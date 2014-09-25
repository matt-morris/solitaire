class Deck
  def initialize
    @cards = [:Spades, :Clubs, :Hearts, :Diamonds].map do |suit|
      (1..13).map do |rank|
        Card.new rank, suit
      end
    end.flatten
  end

  def shuffle
    @cards.shuffle!
    self
  end

  def draw
    @cards.first
  end
end

class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank =
      case rank
      when 1
        :A
      when 11
        :J
      when 12
        :Q
      when 13
        :K
      else
        rank
      end
    @suit = suit
  end
end

# p Deck.new.shuffle.draw

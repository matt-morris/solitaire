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

  def draw(draw_number: 1)
    @cards.slice! -draw_number, draw_number
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

class Solitaire
  attr_reader :table

  def initialize(draw_number: 3)
    @draw_number = draw_number
    @deck = Deck.new.shuffle
    @table = {
      foundation: {
        spades: [], clubs: [], hearts: [], diamonds: []
      },

      tableau: (1..7).map { [] },

      pile: {
        stock: [], waste: []
      }
    }
  end

  def deal
    @table[:tableau].each_with_index do |_, i|
      (i...@table[:tableau].length).each_with_index do |_, j|
        card = @deck.draw.first
        p "[#{i}, #{j}] #{card.rank} of #{card.suit}"
        @table[:tableau][i + j].push card
      end
    end
    self
  end

  def draw
    @deck.draw @draw_number
  end
end

# p Solitaire.new.deal.table[:tableau].each_with_index { |column, i| p "column #{i}:"; column.each { |card| p card } }
# p Deck.new.shuffle.draw
# p Card.new(2, :Spades).rank

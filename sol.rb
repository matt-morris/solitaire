require 'pry'

class Card
  attr_reader :rank, :suit
  attr_accessor :face_up

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
    @face_up = false
  end

  def red?
    [:Diamonds, :Hearts].include? @suit
  end

  def black?
    [:Spades, :Clubs].include? @suit
  end
end

class Solitaire
  attr_reader :table

  def initialize(draw_number: 3)
    @draw_number = draw_number
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
    deck = build_deck.shuffle!
    @table[:tableau].each_with_index do |_, i|
      (i...@table[:tableau].length).each_with_index do |_, j|
        @table[:tableau][i + j].push deck.slice! 0
      end
    end
    @table[:pile][:stock] += deck
    self
  end

  def draw
    drawn = @table[:pile][:stock].slice! -@draw_number, @draw_number
    if drawn
      drawn.each { |card| card.face_up = true }
      @table[:pile][:waste] += drawn
    else
      @table[:pile][:stock] = @table[:pile][:waste].slice!(0, @table[:pile][:waste].size)
                                                   .each { |card| card.face_up = false }
      draw
    end
  end

  private

  def build_deck
    [:Spades, :Clubs, :Hearts, :Diamonds].map do |suit|
      (1..13).map do |rank|
        Card.new rank, suit
      end
    end.flatten
  end
end

sol = Solitaire.new.deal
binding.pry

# p Solitaire.new.deal.draw
# p Deck.new.shuffle.draw
# p Card.new(2, :Spades).rank

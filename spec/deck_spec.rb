require_relative 'spec_helper'
require_relative '../src/table/deck'
require 'pp'

RSpec.describe "Deck" do
  context 'setting up game deck' do
    it 'has 54 cards in one deck' do
      deck = Deck.new [], 1
      expect(deck.cards.count).to eq(54)
    end
    it 'has 108 cards in two decks'do
      deck = Deck.new [], 2
      expect(deck.cards.count).to eq(108)
    end
    it 'has the number of cards given it' do
      deck = Deck.new %w(3h 5s 4d 10c 1h)
      expect(deck.cards.count).to eq(5)
    end
  end
  context 'Durring a game I can' do
    it 'ask for a certain number of cards' do
      deck = Deck.new [], 1
      expect(deck.draw_cards(4).count).to eq(4)
    end
  end
end

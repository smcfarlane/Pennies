require_relative 'spec_helper'
require_relative '../src/players/player'
require_relative '../src/players/players'
require_relative '../src/table/deck'

RSpec.describe 'Players' do
  context 'a set of players in a new state ' do
    players = Players.new %w(tom dick harry)
    deck = Deck.new
    it 'has a list of players' do
      expect(players.list[0]).to respond_to(:name)
      expect(players.list[1]).to respond_to(:hand)
      expect(players.list[2]).to respond_to(:score)
    end
  end

  context 'a set of Players from an existing game' do
    players = Players.new [
      { 'name' => 'john',
        'score' => 0,
        'hand' => [],
        'position' => 0
    },
      {
        'name' => 'sally',
        'score' => 0,
        'hand' => [],
        'position' => 1
      },
      {
        'name' => 'lisa',
        'score' => 0,
        'hand' => [],
        'position' => 2
      },
      {
        'name' => 'steve',
        'score' => 0,
        'hand' => [],
        'position' => 3
      }
    ]

    deck = Deck.new
    it 'has a list of players' do
      expect(players.list[0]).to respond_to(:name)
      expect(players.list[1]).to respond_to(:hand)
      expect(players.list[2]).to respond_to(:score)
    end
  end
end

require_relative 'spec_helper'
require_relative '../src/players/player'
require_relative '../src/players/hand'
require_relative '../src/table/deck'

RSpec.describe "Player" do
  context 'a player' do
    player = Player.new('john',0, Hand.new)
    it 'has a hand' do
      expect(player).to respond_to(:hand)
    end
    it 'has a hand that is a Hand' do
      expect(player.hand.is_a? Hand).to be
    end
    it 'has a score' do
      expect(player).to respond_to(:score)
    end
    it 'has a position' do
      expect(player).to respond_to(:position)
    end
    it 'has a name' do
      expect(player).to respond_to(:name)
    end
  end
end

require_relative 'spec_helper'
require_relative '../src/play/validators'
require_relative '../src/rules'
require 'pp'

RSpec.describe 'Round Validator' do
  context 'Validate based on Round 2' do
    it 'returns no messages to a valid play' do
      p = {"player" => "john", "position" => 0, "down" => false, "cards_played" => {"sets" => [%w(2h 3s 3d), %w(5h 5s 5d)], "other" => %w(7s 6h)}}
      play = Play.new p, 2
      v = RoundSubValidator.new play
      v.validate
      expect(v.results).to eq([])
    end

    it 'returns a message to an invalid play' do
      p = {"player" => "john", "position" => 0, "down" => false, "cards_played" => {"sets" => [%w(2h 3s 3d)], "other" => %w(7s 6h)}}
      play = Play.new p, 2
      v = RoundSubValidator.new play
      v.validate
      expect(v.results).not_to eq([])
    end
  end

  context 'Validate if player is down' do
    it 'player is down' do
      p = {"player" => "john", "position" => 0, "down" => true, "cards_played" => {"sets" => [%w(2h 3s 3d)], "other" => %w(7s 6h)}}
      play = Play.new p, 2
      v = RoundSubValidator.new play
      v.validate
      expect(v.results).to eq([])
    end
  end
end

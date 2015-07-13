require_relative 'spec_helper'
require_relative '../src/play/play'

RSpec.describe 'Play' do
  context 'Set up a New play' do
    p = {"player" => "john", "position" => 0, "down" => false, "cards_played" => {"sets" => [], "other" => []}}
    play = Play.new p, 1
    it 'yeilds if down' do
      expect(play.if_down {true}).to be_falsey
    end

    it 'yeilds if not down' do
      expect(play.if_not_down {true}).to be_truthy
    end
  end
end

require_relative 'spec_helper'
require_relative '../src/play/validators'

RSpec.describe 'OtherSubValidator' do
  context 'Player plays cards other than sets' do
    it 'returns no messages to a valid play' do
      other = %w(7s 2c)
      table = {
        "seven" => %w(7s 7d 7h 7c),
      }
      v = OtherSubValidator.new other, table
      v.validate
      expect(v.results).to eq([])
    end

    it 'returns no messages to a valid play' do
      other = %w(7s 8d 2c)
      table = {
        "seven" => %w(7s 7d 7h 7c),
      }
      v = OtherSubValidator.new other, table
      v.validate
      expect(v.results).not_to eq([])
    end
  end
end

require_relative '../rules'
require_relative 'card'

class Table
  attr_reader :table
  def initialize table
    @sets = table.keys
    @table = table
    @table['wilds'] unless @sets.include? 'wilds'
  end

  def play_set set
    a = []
    set.each do |card|
      c = Card.new card
      c.if_not_wild {a.push c}
    end
    if @sets.include? a[0].set_name
      @table[set_name] << set
    else
      @table[set_name] = set
    end
  end

  def play_other card
    c = Card.new card
    c.if_wild {@table['wilds'] << card }
    c.if_not_wild {@table[c.set_name]}
  end
end

require_relative '../rules'

class PlayValidator
  def initialize
    @messages = []
  end

  def validate(round, play, table, validator_factory: SubValidatorFactory.new)
    @round = round
    @play = play
    @table = table
    @factory = validator_factory
    set_validations
    run_validations
    get_messages
  end

  def results
    @messages
  end

  private

  def set_validations
    @validations = [
      @factory.round_validator(@round, @table),
      @factory.other_validator(@play.cards_played[:other], @table),
    ]
    @play.cards_played[:sets].each {|set| @validations.push(@factory.set_validations(set, @play, @round))}
  end

  def run_validations
    @validations.each {|v| v.validate}
  end

  def get_messages
    @validations.each {|v| @messages.push(v.results).flatten}
  end
end


class SubValidatorFactory
  def round_validator round, play
    RoundSubValidator.new round, play
  end

  def other_validator other, table
    OtherSubValidator.new other,table
  end

  def set_validator set, play, round
    SetSubValidator.new set, play, round
  end
end


class RoundSubValidator
  include Rules
  def initialize play
    @round = play.round
    @play = play
    @messages = []
  end

  def validate
    valid_num_of_sets
  end

  def results
    @messages
  end

  private

  def valid_num_of_sets
    @play.if_not_down do
      @messages.push("#{@play.cards_played["sets"].count} is not enough sets to play down for round #{@round}") if  @play.cards_played["sets"].count < self.round(@round)[:sets]
    end
  end
end

class OtherSubValidator
  def initialize other, table
    @other = other
    @table = table
    @messages = []
  end

  def validate
    @other.each do |card|
      check_with_table card
    end
  end

  def results
    @messages
  end

  private

  def check_with_table card
    unless Rules::WILDS.include? card
      set_name = Rules::CARDS[card[0..-2].to_i]
      @messages.push("#{card} not vaild for sets on table.") unless @table.keys.include? set_name
    end
  end
end

class SetSubValidator
  def initialize set, play, round
    @set = set
    @play = play
    @messages = []
    @play.if_down {@min = 3}
    @play.if_not_down {@min = Rules::round(round)[:of]}
  end

  def validate
    check_set_wilds
    check_set_min
    check_set_contents
  end

  def results
    @messages
  end

  private

  def check_set_wilds
    wilds = 0
    other = 0
    @set.each { |card| Rules::WILDS.include?(card) ? wilds += 1 : other += 1 }
    @message.push('too many wilds') if other / 2 < wilds
  end

  def check_set_min
    @messages.push('Too few cards in the set')  if @set.count < @min
  end

  def check_set_contents
    wilds = 0
    nums = []
    @set.each do |card|
      wilds += 1 if Rules::WILDS.include? card
      nums.push c[0..-2]
    end
    @message.push('Not a vaild set') if nums.uniq.count - wilds != 1
  end
end

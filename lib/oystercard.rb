require './lib/journey_log'
require './lib/journey'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY = 6

  attr_reader :balance, :entry_station, :exit_station, :list_of_journeys, :journey, :journey_klass

  def initialize (balance = 0, journey_klass, journeylog_klass)
    @balance = balance
    @list_of_journeys = journeylog_klass.new
    @journey_klass = journey_klass
  end

  def top_up amount
    raise "Over maximum balance of #{MAXIMUM_BALANCE}" if (@balance + amount) > MAXIMUM_BALANCE
    self.balance += amount
  end


  def touch_in station
    raise "balance less than minimum fare of £#{MINIMUM_BALANCE}" if balance < MINIMUM_BALANCE
    defined
    @journey = journey_klass.new(station)
  end

  def touch_out station
    journey.exit_station = station
    list_of_journeys.log = journey
    deduct
  end

  private

  def deduct
    self.balance -= journey.fare
  end

  def defined
    if defined? journey.complete
       penalty if journey.complete == false
    end
  end

  def penalty
    self.balance -= PENALTY
    journey.exit_station = 'You didn t touch-out!'
    list_of_journeys.log = journey
  end

  attr_accessor :in_use
  attr_writer :balance, :entry_station, :exit_station, :list_of_journeys

end

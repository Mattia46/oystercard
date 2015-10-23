class Journey

  attr_reader :entry, :complete, :zone, :exit_station
  attr_writer :complete
  MIN_FARE = 1

  def initialize entry
    @entry = entry
    @complete = false
  end

  def exit_station= station
    @exit_station = station
    self.complete = true
  end

  def fare
    ((entry.zone - exit_station.zone).abs + MIN_FARE)
  end

end

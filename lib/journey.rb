require_relative 'oystercard'

class Journey

  attr_accessor :entry_station, :exit_station

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

  def fare
    !@entry_station || !@exit_station ? PENALTY_FARE : MINIMUM_FARE
  end

  def complete?
    !!@entry_station && !!@exit_station
  end
end

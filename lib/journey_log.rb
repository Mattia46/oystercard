class JourneyLog

  attr_reader :log

  def initialize
    @log = []
  end

  def log= journey
    @log << journey
  end

end
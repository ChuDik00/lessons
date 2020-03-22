class WagonPassenger < Wagon

  def initialize(number, type = :passenger)
    @type = type
    super
  end
end

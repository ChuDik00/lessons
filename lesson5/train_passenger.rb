class TrainPassenger < Train

  def initialize(number, type = :passenger)
    super
  end

  def add_wagon(wagon)
    if @type == wagon.type
      super(wagon)
    else
      nil
    end
  end
end
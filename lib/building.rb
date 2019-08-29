class Building
  attr_reader :units

  def initialize
    @units = []
  end

  def add_unit(unit)
    @units.push(unit)
  end

  def average_rent
    count = @units.reduce(0) do |sum, unit|
      sum += unit.monthly_rent
    end
    count.to_f / @units.length
  end

  def rented_units
    @units.find_all do |unit|
      unit.renter != nil
    end
  end

  def renter_with_highest_rent
    rented_units.max_by do |rented_unit|
      rented_unit.monthly_rent
    end.renter
  end

  def annual_breakdown
    breakdown = Hash.new
    rented_units.each do |unit|
      breakdown[unit.renter.name] = unit.monthly_rent * 12
    end
    breakdown
  end
end

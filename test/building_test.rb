require 'minitest/autorun'
require 'minitest/pride'
require './lib/building'
require './lib/apartment'
require './lib/renter'

class BuildingTest < Minitest::Test
  def setup
    @building = Building.new
    @a1 = Apartment.new({
      number: "A1",
      monthly_rent: 1200,
      bathrooms: 1,
      bedrooms: 1
    })
    @b2 = Apartment.new({
      number: "B2",
      monthly_rent: 999,
      bathrooms: 2,
      bedrooms: 2
    })
    @jessie = Renter.new("Jessie")
    @spencer = Renter.new("Spencer")
  end

  def test_it_has_attributes
    assert_equal [], @building.units
  end

  def test_it_can_add_units
    @building.add_unit(@a1)

    assert_equal [@a1], @building.units

    @building.add_unit(@b2)

    assert_equal [@a1, @b2], @building.units
  end

  def test_it_can_find_average_rent
    @building.add_unit(@a1)
    @building.add_unit(@b2)
    expected = 1099.5

    assert_equal expected, @building.average_rent
  end

  def test_renter_with_highest_rent
    @b2.add_renter(@spencer)
    @building.add_unit(@a1)
    @building.add_unit(@b2)
    actual = @building.renter_with_highest_rent

    assert_equal @spencer, actual

    @a1.add_renter(@jessie)
    @building.renter_with_highest_rent
    actual = @building.renter_with_highest_rent

    assert_equal @jessie, actual
  end

  def test_it_can_provide_annual_breakdown
    @b2.add_renter(@spencer)
    @building.add_unit(@a1)
    @building.add_unit(@b2)
    expected = {"Spencer" => 11988}
    actual = @building.annual_breakdown

    assert_equal expected, actual

    @a1.add_renter(@jessie)
    actual = @building.annual_breakdown
    expected = {"Jessie" => 14400, "Spencer" => 11988}

    assert_equal expected, actual
  end
end

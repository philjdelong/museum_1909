require 'minitest/autorun'
require 'minitest/pride'
require './lib/museum'
require './lib/exhibit'
require './lib/patron'
require 'pry'

class MuseumTest < Minitest::Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)
    @bob = Patron.new("Bob", 20)
    @sally = Patron.new("Sally", 20)
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_initializes_with_name_and_exhibits
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_it_can_add_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  def test_it_can_recommend_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @dmns.admit(@bob)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @dmns.admit(@sally)
    @sally.add_interest("IMAX")

    assert_equal [@gems_and_minerals, @dead_sea_scrolls], @dmns.recommend_exhibits(@bob)
    assert_equal [@imax], @dmns.recommend_exhibits(@sally)
  end

  def test_it_can_admit_patrons
    @dmns.admit(@bob)
    @dmns.admit(@sally)

    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_it_can_tell_patrons_by_exhibit_interest
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @dmns.admit(@bob)
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    @dmns.admit(@sally)
    @sally.add_interest("Dead Sea Scrolls")

    # assert_equal [@bob], @dmns.patrons_by_exhibit_interest(@gems_and_minerals)
    # assert_equal [@bob], @dmns.patrons_by_exhibit_interest(@dead_sea_scrolls)
    # assert_equal [@sally], @dmns.patrons_by_exhibit_interest(@imax)
    expected = {
      @gems_and_minerals => [@bob],
      @dead_sea_scrolls => [@bob,@sally],
      @imax => []
    }
    assert_equal expected, @dmns.patrons_by_exhibit_interest
  end
end

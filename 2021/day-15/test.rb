require 'test/unit'
require_relative 'day-15'

class Day15Test < Test::Unit::TestCase

  def test_calc_heights
    data = [
      '83', # 9, 4, 1, 5
      '12'  # 2, 3, 3, 4
    ] #94     1  5  2  6
      #23     3  4  4  5
      #15
      #34

    rows = process_data(data)

    assert_equal [9, 2], calc_heights(rows, [0,1]), "Right and down from 3 are #{[9,2]}"
    assert_equal [4, 2], calc_heights(rows, [0,2]), "Right and down from 9 are #{[4,2]}"
    assert_equal [3, 5], calc_heights(rows, [3,1]), 'Right and down from 3 at [3,1] are [3,5]'
  end
end



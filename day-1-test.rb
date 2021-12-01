require 'test/unit'
require_relative 'day-1'

class TwainMarkerTest < Test::Unit::TestCase
  def test_model_exists
    assert_not_nil TwainMarker, 'Class does not exist'
  end

  def test_marker
    test_data = %w(
      199
      200
      208
      210
      200
      207
      240
      269
      260
      263
      197
    ).map{ |d| d + "\n"}
    marker = TwainMarker.new(test_data)
    assert_equal marker.relative_increases, 7, 'Did not calculate the correct number'
  end
end

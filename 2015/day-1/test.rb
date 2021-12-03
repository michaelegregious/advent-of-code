require 'test/unit'
require_relative 'day-1'

class Day1Test < Test::Unit::TestCase
  def test_elevate
    tests = {
      "test0"=>"(())",
      "test1"=>"()()",
      "test2"=>"(((",
      "test3"=>"(()(()(",
      "test4"=>"))(((((",
      "test5"=>"())",
      "test6"=>"))(",
      "test7"=>")))",
      "test8"=>")())())"
    }
    expectations = [0,0,3,3,3,-1,-1,-3,-3]
    9.times.each do |n|
      assert_equal elevate_the_fat_man(tests["test#{n}"]), expectations[n], "Test #{n} is failing"
    end
  end
end



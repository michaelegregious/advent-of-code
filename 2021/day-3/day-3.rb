#!/usr/bin/env ruby

data = File.open('./data.txt').readlines

# part 1
def gamma_epsilon_diagnostics(binary)
  tally = [] # [ count 0, count 1 ] per index

  binary.each do |str|
    str.chomp.chars.each_with_index do |char, i|
      tally[i] ||= [0, 0]
      if char == '0'
        tally[i][0] += 1
      elsif char == '1'
        tally[i][1] += 1
      end
    end
  end

  gamma = tally
    .map { |pair| pair[0] > pair[1] ? 0 : 1 }
    .join
    .to_i(2)

  epsilon = tally
    .map { |pair| pair[0] < pair[1] ? 0 : 1 }
    .join
    .to_i(2)

  gamma * epsilon
end

# part 2
class LifeSupportDiagnostics
  def initialize(data = BINARY)
    @data = data
  end

  def life_support_rating()
    @o2 = oxygen_generator_rating
    @co2 = co2_scrubber_rating
    @o2.to_i(2) * @co2.to_i(2)
  end

  def oxygen_generator_rating(data = @data, selected_index = 0)
    @initial_pairs ||= gamma_epsilon_pairs(data)
    pairs = selected_index == 0 ? @initial_pairs : gamma_epsilon_pairs(data)
    most_common = most_common_per_index(pairs)
    filtered = []

    data.each_with_index do |str, i|
      char = str.chomp[selected_index]
      if char == most_common[selected_index]
        filtered << str
      elsif most_common[selected_index] == 'tie' && char == '1'
          filtered << str
      end
    end

    if filtered.size == 1
      return filtered[0]
    else
      oxygen_generator_rating(filtered, selected_index + 1)
    end
  end

  def co2_scrubber_rating(data = @data, selected_index = 0)
    @initial_pairs ||= gamma_epsilon_pairs(data)
    pairs = selected_index == 0 ? @initial_pairs : gamma_epsilon_pairs(data)
    least_common = least_common_per_index(pairs)
    filtered = []

    data.each_with_index do |str, i|
      char = str.chomp[selected_index]
      if char == least_common[selected_index]
        filtered << str
      elsif least_common[selected_index] == 'tie' && char == '0'
          filtered << str
      end
    end

    if filtered.size == 1
      return filtered[0]
    else
      co2_scrubber_rating(filtered, selected_index + 1)
    end
  end

  private

  def most_common_per_index(pairs)
    pairs.map do |pair|
      if pair[0] > pair[1] then '0'
      elsif pair[0] < pair[1] then '1'
      else 'tie'
      end
    end
  end

  def least_common_per_index(pairs)
    pairs.map do |pair|
      if pair[0] > pair[1] then '1'
      elsif pair[0] < pair[1] then '0'
      else 'tie'
      end
    end
  end

  def gamma_epsilon_pairs(data)
    tally = []
    data.each do |str|
      str.chomp.chars.each_with_index do |char, i|
        tally[i] ||= [0, 0]
        if char == '0' then tally[i][0] += 1
        elsif char == '1' then tally[i][1] += 1
        end
      end
    end
    tally
  end
end

p LifeSupportDiagnostics.new(data).life_support_rating

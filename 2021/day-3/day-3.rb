#!/usr/bin/env ruby

data = File.open('./data.txt').readlines

test_data = %w(
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
)

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

# consider first bit of data
# keep only Ns of the bit criteria
# if only one number left, stop, that's it
# else repeat the process, moving one column to the right

# bit criteria:
# oxygen gen rating:
#  - consider most common val, 0 or 1
#  - if equally common, keep values with 1
#  CO2 rating:
#  - least common value, 0 or 1
#  - if equally common, keep 0

# part 2
class LifeSupportDiagnostics
  def initialize(data = BINARY)
    @data = data
  end

  def oxygen_generator_rating(data = @data, selected_index = 0)
    @pairs ||= gamma_epsilon_pairs(data)
    @most_common = most_common_per_index(pairs)
    selected = []

    data.each_with_index do |str, i|
      if str.chomp[selected_index] == most_common[selected_index]
        selected << str
      end
    end

    if selected_indices.size == 1
      return selected[0]
    else
      oxygen_generator_rating(selected, selected_index + 1)
    end
  end





  private

  def most_common_per_index(pairs)
    pairs.map{ |pair| pair[0] > pair[1] ? 0 : 1 }
  end

  def gamma_epsilon_pairs(data)
    tally = [] # [ count 0, count 1 ] per index

    binary.each do |str|
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



p gamma_epsilon_pairs(test_data)
# p run_diagnostics(test_data)


# def CO2_scrubber_rating(data = @data, selected_index = 0)
#   @pairs ||= gamma_epsilon_pairs(data)
#   @most_common = most_common_per_index(pairs)
#   selected = []

#   data.each_with_index do |str, i|
#     if str.chomp[selected_index] != most_common[selected_index]
#       selected << str
#     end
#   end

#   if selected_indices.size == 1
#     return selected[0]
#   else
#     C02_rating(selected, selected_index + 1)
#   end
# end

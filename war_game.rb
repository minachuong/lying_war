require_relative 'io_helpers'
# require_relative 'small-data-set'
# TestCase.new
# file = File.open("small-data-set.txt", "r")
# contents = file.read
# puts contents
# number_of_blocks = 6
# noami = [0.27, 0.55, 0.91, 0.33, 0.52, 0.30]
# ken = [0.85, 0.45, 0.06, 0.24, 0.12, 0.88]

# data_set = DataSet.build(:small)
data_set = DataSet.build(:large)

#
def ken_pick_block(chose_naomi, ken_array)
  game_array = ken_array
  chosen_ken = game_array[0]

  game_array.each do |block|
    if block > chose_naomi
      return block
    end
  end
  chosen_ken
end

def regular_war(ken_array, naomi_array)
  n_sorted = naomi_array.sort{ |first, second| first <=> second }
  k_sorted = ken_array.sort{ |first, second| first <=> second }
  naomi_wins = 0
  n_sorted.each do |chose_naomi|
    chosen_ken = ken_pick_block(chose_naomi, k_sorted)
    chosen_ken
    if chosen_ken < chose_naomi
      naomi_wins += 1
    end
    k_sorted.delete(chosen_ken)
  end
  naomi_wins
end

def naomi_pick_block(chosen_ken, naomi_array)
  naomi_array.each do |block|
    return block if block > chosen_ken
  end
  0
end

def max_naomi_wins(ken_array, naomi_array)
  n_sorted = naomi_array.sort{ |first, second| first <=> second }
  k_sorted = ken_array.sort{ |first, second| first <=> second }
  potential_wins = 0
  k_sorted.each do |chosen_ken|
    chosen_naomi = naomi_pick_block(chosen_ken, n_sorted)
    if chosen_naomi > chosen_ken
      potential_wins += 1
      n_sorted.delete(chosen_naomi)
    end
  end
  potential_wins
end

def lying_war(ken_array, naomi_array)
  sorted_n = naomi_array.sort!{ |first, second| first <=> second }
  sorted_k = ken_array.sort!{ |first, second| first <=> second }
  naomi_wins = max_naomi_wins(sorted_k, sorted_n)
end

data_set.cases.each_with_index do |game_case, i|
  puts "Case #{i+1}: #{regular_war(game_case.ken_block_weights, game_case.naomi_block_weights)} #{lying_war(game_case.ken_block_weights, game_case.naomi_block_weights)}"
end

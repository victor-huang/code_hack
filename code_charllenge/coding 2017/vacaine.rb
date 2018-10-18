
require 'pry'

def solve(population_in_cities, total_clinics)
  allowed_to_allocaated_clinics = total_clinics - population_in_cities.size

  clinics_assignments = Array.new(population_in_cities.size, 1)

  require_vacination_kits_clinics_per_cities = population_in_cities.each_with_index.map do |poulation, i|
    [i,  poulation / clinics_assignments[i]]
  end

  while allowed_to_allocaated_clinics != 0
    need_to_allowcate_more_clinics_city_index = require_vacination_kits_clinics_per_cities.sort_by { |elm| -elm[1] }.first[0]

    clinics_assignments[need_to_allowcate_more_clinics_city_index] += 1
    allowed_to_allocaated_clinics -= 1

    require_vacination_kits_clinics_per_cities = population_in_cities.each_with_index.map do |poulation, i|
      [i,  poulation / clinics_assignments[i]]
    end

    puts clinics_assignments.inspect
  end

  puts "#{clinics_assignments[need_to_allowcate_more_clinics_city_index]}, \
  #{population_in_cities[need_to_allowcate_more_clinics_city_index] / clinics_assignments[need_to_allowcate_more_clinics_city_index]}"
end


def test
  cities = [200000, 500000]

  puts solve(cities, 7)

end

test()

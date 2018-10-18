require 'pry'

def cavityMap(matrix)

  map_size = matrix.size
  max_exam_index = map_size - 2
  cavity_map_hash = {}

  if map_size >= 2
    (1..max_exam_index).each do |x|
      (1..max_exam_index).each do |y|

        current_depth = matrix[x][y]
        # binding.pry if x == 1 && y == 1
        if current_depth > matrix[x][y - 1] && current_depth > matrix[x + 1][y] &&
            current_depth > matrix[x][y + 1] && current_depth > matrix[x - 1][y]
          cavity_map_hash["#{x},#{y}"] = 'X'
        end
      end
    end
  end

  # print out the map

  # puts cavity_map_hash.inspect

  result = []

  (0..(map_size - 1)).each do |x|
    result_line = ''

    (0..(map_size - 1)).each do |y|
      result_at_position = cavity_map_hash["#{x},#{y}"] ? cavity_map_hash["#{x},#{y}"] : matrix[x][y]
      result_line += result_at_position.to_s
    end
    result << result_line
  end

  result
end



def test

  array = [[1, 1, 1, 2],
           [1, 9, 1, 2],
           [1, 8, 9, 2],
           [1, 2, 3, 4]
  ]

  cavityMap(array)
end

puts test()


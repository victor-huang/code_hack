##########################
# Developer: Victor Huang
# Date: 2/16/2017
# Time to solve the problem: 4 hours
##########################

require 'pp'

class BlobBoundarySolver
  attr_reader :number_of_cell_visited

  # assume this is only one valid blob in the arrays
  def initialize(two_dimensional_array)
    @matrix = two_dimensional_array
    @width = @matrix[0].size
    @height = @matrix.size

    @number_of_cell_visited = 0

    # these hashs help to reduce the number of cell visits
    @not_all_zero_row_index = {}
    @all_zero_row_index = {}
    @not_all_zero_col_index = {}
    @all_zero_col_index = {}
  end

  def size
    @width * @height
  end

  def solve
    # find the blob's boundary in horzontal dimension
    @left, @right = find_boundary_in_one_dimension(0, @width - 1, 'col')

    # find the blob's boundary in vertical dimension
    @top, @bottom = find_boundary_in_one_dimension(0, @height - 1, 'row')

    puts "cell visited #{@number_of_cell_visited}"
    puts "top: #{@top}, left: #{@left}, bottom: #{@bottom}, right: #{@right}"

    [@top, @left, @bottom, @right]
  end

  def find_boundary_in_one_dimension(lower, upper, array_dimension)
    # try to use binary search like method to achieve evenly distributed search in the space,
    # and help to reduce the search space
    find_all_zeros_entries_method = if array_dimension == 'col'
      initial_upper = @width - 1
      :binary_serach_all_zero_col
    else
      initial_upper = @height - 1
      :binary_serach_all_zero_row
    end

    previouse_boundary = [lower, upper]

    # the idea is to reduce the initial lower and upper bounds by finding the one row/column that's has all zeros
    # if there is such an entry exists we can reduce the bounds properly, and repeat this process until all row/column
    # are visited or the bounds doesn't change
    (0..initial_upper).each do |i|
      new_boundary = self.send(find_all_zeros_entries_method, lower, upper)

      break unless new_boundary

      if new_boundary >= upper
        upper = upper - 1
      elsif new_boundary <= lower
        lower = lower + 1
      else new_boundary > lower && new_boundary < upper # in between case
        if (new_boundary - lower).abs <= (new_boundary - upper).abs
          lower = new_boundary # closer to lower
        else
          upper = new_boundary # closer to right
        end
      end

      break if previouse_boundary == [lower, upper]

      previouse_boundary = [lower, upper]
    end

    return [lower, upper]
  end

  def get_optimized_col_bounds
    lower = @left || 0
    upper = @right || @width - 1
    [lower, upper]
  end

  # it tries to split the problem space into two parts and start from the middle to find the
  # all zeros array, worst case still need to search the whole space, and it doesn't really
  # help much to reduce the problem space by half, as originally thought it would.
  # it is used for achieving a uniformly search in the problem space.
  def binary_serach_all_zero_row(top, bottom)
    mid_index = top + (bottom - top) / 2
    all_zeros = true

    if bottom < top
      bottom = top
    end

    if top > bottom
      top = bottom
    end

    if top == bottom
      mid_index = top
    end

    if @not_all_zero_row_index[mid_index]
      all_zeros = false
    else
      unless @all_zero_row_index[mid_index]
        lower, upper = get_optimized_col_bounds
        (lower..upper).each do |i|
          cell = @matrix[mid_index][i]

          if cell != 0
            all_zeros = false
            @not_all_zero_col_index[i] = true
            @not_all_zero_row_index[mid_index] = true
            @number_of_cell_visited += 1
            break
          end

          @number_of_cell_visited += 1
        end

        @all_zero_row_index[mid_index] = true
      end
    end

    if all_zeros
      return mid_index
    elsif top == bottom
      return nil
    else
      new_top = mid_index + 1
      new_bottom = bottom
      result = binary_serach_all_zero_row(new_top, new_bottom)
      return result if result

      new_top = top
      new_bottom = mid_index - 1
      return binary_serach_all_zero_row(new_top, new_bottom)
    end
  end

  def get_optimized_row_bounds
    lower = @top || 0
    upper = @bottom || @height - 1
    [lower, upper]
  end

  # it is possible to refactor :binary_serach_all_zero_col and :binary_serach_all_zero_row
  # to be one method
  def binary_serach_all_zero_col(left, right)
    mid_index = left + (right - left) / 2
    all_zeros = true

    if right < left
      right = left
    end

    if left > right
      left = right
    end

    if left == right
      mid_index = left
    end

    if @not_all_zero_col_index[mid_index]
      all_zeros = false
    else
      unless @all_zero_col_index[mid_index]
        lower, upper = get_optimized_row_bounds

        (lower..upper).each do |i|
          cell = @matrix[i][mid_index]

          if cell != 0
            all_zeros = false
            @not_all_zero_row_index[i] = true
            @not_all_zero_col_index[mid_index] = true
            @number_of_cell_visited += 1
            break
          end

          @number_of_cell_visited += 1
        end

        @all_zero_col_index[mid_index] = true
      end
    end

    if all_zeros
      return mid_index
    elsif left == right
      return nil
    else
      new_left = mid_index + 1
      new_right = right
      result = binary_serach_all_zero_col(new_left, new_right)
      return result if result

      new_left = left
      new_right = mid_index - 1
      return binary_serach_all_zero_col(new_left, new_right)
    end
  end
end

class Test
  @@matrix = [
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0],
    [0, 0, 1, 0, 0],
    [0, 1, 1, 0, 0],
  ]

  def self.binary_serach_all_zero_row_should_work
    solver = BlobBoundarySolver.new(@@matrix)
    puts solver.binary_serach_all_zero_row(3, 4) == nil
    puts solver.binary_serach_all_zero_row(0, 4) == 0
    puts solver.binary_serach_all_zero_row(1, 4) == 1
    puts "visited #{solver.number_of_cell_visited}, total #{@@matrix[0][0].size * @@matrix[0].size}"
  end

  def self.binary_serach_all_zero_col_should_work
    solver = BlobBoundarySolver.new(@@matrix)
    puts solver.binary_serach_all_zero_col(1, 2) == nil
    puts solver.binary_serach_all_zero_col(0, 4) == 3
    puts solver.binary_serach_all_zero_col(0, 2) == 0
    puts solver.binary_serach_all_zero_col(4, 4) == 4

    puts "visited #{solver.number_of_cell_visited}, total #{@@matrix[0][0].size * @@matrix[0].size}"
  end

  def self.solve_should_work
    solver = BlobBoundarySolver.new(@@matrix)
    puts solver.solve == [2, 1, 4, 2]
  end
end

# Tests
# Test.binary_serach_all_zero_row_should_work
# Test.binary_serach_all_zero_col_should_work
# Test.solve_should_work

# Run
#
problem_matrix = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 1, 1, 1, 1, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 1, 0, 0, 0],
    [0, 0, 1, 1, 1, 1, 1, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 1, 0, 1, 0, 0, 0],
    [0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
]

pp problem_matrix
puts
solver = BlobBoundarySolver.new(problem_matrix)
solver.solve

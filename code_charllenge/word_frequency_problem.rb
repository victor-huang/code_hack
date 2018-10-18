##########################
# Developer: Victor Huang
# Date: 2/16/2017
# Time to solve the problem: 2 hours
##########################

require 'pp'
require 'benchmark'

class WordCountLib
  # assume text without any Unicodes
  def initialize(text)
    @text = text
  end

  def frequencey_count
    sentences = sanitize_text(@text.downcase).split('.')
    words_count = {}
    words_in_sentences = {}

    sentences.each_with_index do |sentence, setence_index|
      words = sentence.split(' ')
      words.each do |word|
        words_count[word] ||= 0
        words_count[word] += 1

        words_in_sentences[word] ||= []

        setence_number = setence_index + 1
        words_in_sentences[word] << setence_number
      end
    end

    {
      number_of_sentence: sentences.count,
      words_count: words_count,
      words_in_sentences: words_in_sentences
    }
  end

  # this method optimize the use of memory and only need to visit the text once
  # after sanitization
  # it is not tested with Unicode, it might not work correctly if Unicode is present
  def frequencey_count_optimized
    sanitized_text = sanitize_text(@text.downcase)

    current_sentence_num = 1
    current_word = ''
    words_count = {}
    words_in_sentences = {}
    current_index = 0

    sanitized_text.each_char do |char|
      next if char == ' ' && current_word == ''
      next if char == '.' && current_word == ''

      # process the previouse saved word
      if char == ' ' || current_index == sanitized_text.size - 1
        words_count[current_word] ||= 0
        words_count[current_word] += 1

        words_in_sentences[current_word] ||= []
        words_in_sentences[current_word] << current_sentence_num
        current_word = ''
      elsif char != '.'
        current_word += char
      elsif char == '.'
        words_count[current_word] ||= 0
        words_count[current_word] += 1

        words_in_sentences[current_word] ||= []
        words_in_sentences[current_word] << current_sentence_num
        current_word = ''

        current_sentence_num += 1
      end

      current_index += 1
    end

    {
      number_of_sentence: current_sentence_num,
      words_count: words_count,
      words_in_sentences: words_in_sentences
    }
  end

  def frequency_count_with_occurrence_sentence_numbers(optimized: false)
    count_data = optimized ? frequencey_count_optimized : frequencey_count

    count_hash = count_data[:words_count].inject({}) do |result, (word, count)|
      result[word] = [count, count_data[:words_in_sentences][word]]
      result
    end

    count_hash.sort_by { |k, entry| k }
  end

  def sanitize_text(text)
    # remove punucation charater except for .
    # reference: http://stackoverflow.com/questions/4328500/how-can-i-strip-all-punctuation-from-a-string-in-javascript-using-regex
    text.gsub(/[,\/#!$%\^&\*;:{}=\-_`~()]/, ' ')
  end
end


# Tests
class Test
  def self.expect_frequency_counter_to_work
    text = "Bridgewater is the top hedge fund firm in the American. bridgewater beat other hedge fund and the market consistently."
    answer = {
      "bridgewater"=>2,
      "is"=>1,
      "the"=>3,
      "top"=>1,
      "hedge"=>2,
      "fund"=>2,
      "firm"=>1,
      "in"=>1,
      "american"=>1,
      "beat"=>1,
      "other"=>1,
      "and"=>1,
      "market"=>1,
      "consistently"=>1
    }

    word_frequency_lib = WordCountLib.new(text)
    count_data = word_frequency_lib.frequencey_count
    count_data_2 = word_frequency_lib.frequencey_count_optimized

    puts "Test.#{__method__} passed" if count_data[:words_count] == answer
    puts "Test.#{__method__} optimized passed" if count_data[:words_count] == count_data_2[:words_count]
    puts "Test.#{__method__} words_in_sentence optimized passed" if count_data[:words_in_sentences] == count_data_2[:words_in_sentences]
  end

  def self.expect_frequency_count_with_occurrence_sentence_numbers_to_work
    text = "a is in the car. b is on the bike. a is out hidden. c is out."

    answer = {
      "a"=>[2, [1, 3]],
      "is"=>[4, [1, 2, 3, 4]],
      "in"=>[1, [1]],
      "the"=>[2, [1, 2]],
      "car"=>[1, [1]],
      "b"=>[1, [2]],
      "on"=>[1, [2]],
      "bike"=>[1, [2]],
      "out"=>[2, [3, 4]],
      "hidden"=>[1, [3]],
      "c"=>[1, [4]]
    }

    word_frequency_lib = WordCountLib.new(text)

    result = word_frequency_lib.frequency_count_with_occurrence_sentence_numbers
    result_2 = word_frequency_lib.frequency_count_with_occurrence_sentence_numbers(optimized: true)

    puts "Test.#{__method__} passed" if result == answer
    puts "Test.#{__method__} with optimized passed" if result == result_2
  end

  # this benchmark test is interesting, it shows that using the native Ruby's string split method actually
  # perform about 4 times better than the "optimized" version of the method. I think it is because it trades of
  # space for time, and the native method is written in C code, which is faster than doing string manipulating
  # in Ruby. for normal text processing, it make sense to use the simple method for simplicity and speed, the
  # optimized method is really reserver for really really large text that doesn't fit in memory
  def self.benchmark_test
    text = "a is in the car. b is on the bike. a is out hidden. c is out."

    15.times { text += text }
    word_frequency_lib = WordCountLib.new(text)

    puts Benchmark.measure {
       word_frequency_lib.frequency_count_with_occurrence_sentence_numbers
    }

    puts Benchmark.measure {
       word_frequency_lib.frequency_count_with_occurrence_sentence_numbers(optimized: true)
    }
  end
end


# Test

# Test.expect_frequency_counter_to_work
# Test.expect_frequency_count_with_occurrence_sentence_numbers_to_work
# Test.benchmark_test

# Run
text  = <<-DOCHERE
    Oroville, California (CNN)A day after 188,000 people were evacuated from the towns surrounding Northern California's Oroville Dam, officials sounded a note of cautious optimism about containing the threat of flooding.
Still, the mandatory evacuation order remained in place Monday for Butte, Sutter and Yuba counties.
The evacuation was ordered Sunday after a massive hole was discovered in an emergency spillway -- which catches excess water when Lake Oroville's water level rises to overflow the dam -- threatening communities downstream.
DOCHERE

puts text.downcase
puts
word_frequency_lib = WordCountLib.new(text)
pp word_frequency_lib.frequency_count_with_occurrence_sentence_numbers


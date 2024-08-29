#!/usr/bin/env -S ruby -w
# frozen_string_literal: true

#
# Implement a recursive binary search method that serves as a helper
#
# @param array The array to search through for the value.
# @param low The index to start searching from in the given array.
# @param high The index to end the search at.
# @param value The value searched.
#
def binary_search_recursive(array, low, high, value)
  return -1 if (low > high) || (high >= array.length)

  mid = (low + high) / 2

  if array[mid] == value
    mid
  elsif array[mid] < value
    binary_search_recursive(array, mid + 1, high, value)
  else
    binary_search_recursive(array, low, mid - 1, value)
  end
end

#
# Return the first occurrence of the given value at the specified index in
# a particular array.
#
# The goal of this method is to return the actual first occurrence of the
# +value+ in an array. It does so by moving backwards down to index 0
# starting from the specified +index+. It checks if the index at the previous
# is the same as the expected value. If it is, it means that the current
# index is not where the initial occurrence is found in the array.
#
# It continues this until a different value is found at which point it
# validates that the index is where the first occurrence of +value+ can be
# found in the given +array+.
#
def first_occurrence(array, index, value)
  first = index # assume the first occurrence is the current index
  index.downto(0) do |i|
    break unless array[i] == value

    first = i
  end
  first # return statement
end

def advanced_binary(array, value)
  return -1 if array.empty? # We can't search an empty array 😅

  index = binary_search_recursive(array, 0, array.length - 1, value)
  puts "Originally found at index #{index}."
  return -1 if index == -1 # let's get out of here, we didn't find it

  first_occurrence(array, index, value)
end

if __FILE__ == $PROGRAM_NAME
  search_value = 5
  arr = [1, 1, 2, 3, 3, 4, 5, 5, 5, 5, 5, 6, 7, 9, 10, 10, 12]
  puts "The first occurrence of #{search_value} was found at index " \
         "#{advanced_binary(arr, search_value)}."
end

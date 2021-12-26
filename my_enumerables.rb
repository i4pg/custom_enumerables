module Enumerable
  def my_each(&block)
    my_each_with_index(&block)
  end

  def my_each_with_index
    index = 0
    length.times do
      item = self[index]
      yield(item, index)
      index += 1
    end
  end

  def my_select
    selected = []
    index = 0
    length.times do
      item = self[index]
      selected.push(item) if yield(item, index) == true
      index += 1
    end
    selected
  end

  def my_all?
    my_each do |item|
      return false if yield(item) == false
    end
    true
  end

  def my_any?
    my_each do |item|
      return true if yield(item) == true
    end
    false
  end

  def my_none?
    my_each do |item|
      return false if yield(item) == true
    end
    true
  end

  def my_count
    if block_given?
      match = 0
      my_each do |item|
        match += 1 if yield(item) == true
      end
      match
    else
      my_each { index }
    end
  end

  def my_map(arg = nil, &block)
    new_array = []
    my_each do |item|
      if arg
        new_array.push(arg.call(item))
      elsif block_given?
        new_array.push(block.call(item))
      end
    end
    new_array
  end

  def my_inject(acc = self[0])
    curr_index = 1
    length.times do
      next if curr_index >= length

      curr = self[curr_index]
      acc = yield(acc, curr)
      curr_index += 1
    end
    acc
  end

  def my_multiply_els
    my_inject { |acc, curr| acc * curr }
  end
end

# testing my Enumerables methods
class Test
  # puts 'my_each vs. each'
  # numbers = [1, 2, 3, 4, 5]
  # # numbers.my_each { |item| puts item }
  # # numbers.each { |item| puts item }

  # puts 'my_each_with_index vs. each_with_index'
  # numbers = [1, 2, 3, 4, 5]
  # # numbers.my_each_with_index { |item, index| puts "#{index}=>#{item}" }
  # # numbers.each_with_index { |item, index| puts "#{index}=>#{item}" }

  # puts 'my_select vs. select'
  # numbers = [1, 2, 3, 4, 5]
  # p numbers.my_select { |item| item < 0 }
  # numbers.select { |item| item > 3 }

  # puts 'my_all? vs. all?'
  # numbers = [1, 2, 3, 4, 5]
  # p numbers.my_all?(&:positive?)
  # numbers.all? { |item| puts item > 0 }

  # puts 'my_any? vs. any?'
  # numbers = [1, 2, 3, 4, 5]
  # numbers.my_any? { |item| item == 5 }
  # numbers.any? { |item| item == 6 }

  # puts 'my_none? vs. none?'
  # numbers = [1, 2, 3, 4, 5]
  # p numbers.my_none? { |item| item == 5 }
  # numbers.none? { |item| item == 5 }

  # puts 'my_count vs. count'
  # numbers = [1, 2, 3, 4, 5]
  # p numbers.my_count { |item| item < 5 }
  # p numbers.my_count
  # numbers.count

  # puts 'my_map? vs. map?'
  numbers = [1, 2, 3, 4, 5]
  map_proc = proc { |item| item + 1 }
  p numbers.my_map(map_proc) { |item| item + 1 }
  # numbers.map { |item| item + 1 }

  # puts 'my_inject? vs. inject?'
  # numbers = [1, 2, 3, 4, 5]
  # numbers.my_inject { |acc, curr| acc + curr }
  # numbers.inject { |acc, curr| acc + curr }
  # numbers.my_multiply_els
end

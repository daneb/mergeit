require "mergeit/version"

module Mergeit
  class Merge
    def initialize
    end

    def say_hello(files_array)
      puts 'Hello World'
      puts files_array[0]
      puts files_array[1]
    end
  end
end

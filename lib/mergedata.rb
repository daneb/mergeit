module Mergeit
  class MergeData
    attr_reader :input_files

    def initialize(input_files)
      @input_files = input_files
    end
  end
end

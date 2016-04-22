require 'mergeit/config'

module Mergeit
  module MergeData
    attr_reader :input_files, :hash_merged_data

    def self.merge_data(input_files)
      for filename in input_files
        merge_into_hash(filename)
      end
    end

    private

    def self.open_file(filename)
      File.open(filename, 'r')
    end

    def self.split_line(line)
      line.split(Mergeit::Config::FILE_FORMAT[:delimeter])
    end

    def self.merge_into_hash(file)
      current_fh = open_file(file)
      current_fh.each_line
    ensure
      current_fh.close
    end
  end
end

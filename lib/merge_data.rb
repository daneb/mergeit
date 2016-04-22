require 'mergeit/config'
require 'ipaddr'

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

    def self.is_ip_addr?(part)
      ip = IPAddr.new(part)
      ip.ipv4?
    rescue IPAddr::InvalidAddressError => e
      false
    end

    def self.is_valid_csv?(part)
      part =~ /#{Mergeit::Config::CSV_FORMAT[:regex]}/
    end

    def self.split_line(line)
      line.split(Mergeit::Config::FILE_FORMAT[:delimeter], Mergeit::Config::SUPPORTED_PARTS[:size])
    end

    def self.merge_into_hash(file)
      current_fh = open_file(file)
      current_fh.each_line
    ensure
      current_fh.close
    end
  end
end

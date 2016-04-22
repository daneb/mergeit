require 'mergeit/config'
require 'ipaddr'

module Mergeit
  class MergeData
    attr_reader :input_files
    attr_accessor :hash_of_merged_data

    def merge_data(input_files)
      for filename in input_files
        merge_into_hash(filename)
      end
      sanitize_hash
    end

    private

    def open_file(filename)
      File.open(filename, 'r')
    end

    def is_ip_addr?(part)
      ip = IPAddr.new(part)
      ip.ipv4?
    rescue IPAddr::InvalidAddressError => e
      false
    end

    def is_valid_csv?(part)
      part =~ /#{Mergeit::Config::CSV_FORMAT[:regex]}/
    end

    def split_line(line)
      line.split(Mergeit::Config::FILE_FORMAT[:delimeter], Mergeit::Config::SUPPORTED_PARTS[:size])
    end

    def store_values_in_existing_key(ip, numbers)
      numbers.each { |number|
        @hash_of_merged_data[ip] << number
      }
    end

    def store_new_key_and_values(ip, numbers)
      @hash_of_merged_data.store(ip, numbers)
    end

    def process_to_hash(ip, numbers)
      if @hash_of_merged_data.has_key?(ip)
        store_values_in_existing_key(ip, numbers)
      else
        @hash_of_merged_data.store(ip, numbers)
      end
    end

    def sanitize_hash
      @hash_of_merged_data.map { |key,value|
        value.uniq!
        value.sort!
      }
    end

    def merge_into_hash(file)
      current_fh = open_file(file)
      current_fh.each_line { |line|
        parts = split_line(line)
        next unless parts.length == Mergeit::Config::SUPPORTED_PARTS[:size]

        ip = parts[0].strip
        next unless is_ip_addr?(ip)

        numbers = parts[1].strip
        next unless is_valid_csv?(numbers)

        process_to_hash(ip, numbers.split(Mergeit::Config::NUMBERS[:delimeter]))
      }
    ensure
      current_fh.close
    end
  end
end

require 'mergeit/config'
require 'ipaddr'

module Mergeit
  # Involved in opening the files, parsing and then \n
  #  merging their content to a hash
  class MergeData
    attr_reader :input_files
    attr_accessor :hash_of_merged_data

    def initialize
    	@input_files = []
    	@hash_of_merged_data = {}
    end

    # Heart of the merge process. 
    # @return Returns a sanitized version of the merged data \n
    # (unique and sorted)
    def merge_data(input_files)
      for filename in input_files
        merge_into_hash(filename)
      end
      sanitize_hash
    end

    private

    # Open a file in read-only mode
    def open_file(filename)
      File.open(filename, 'r')
    end

    # Validates if a string is an ipv4 address
    def is_ip_addr?(part)
      ip = IPAddr.new(part)
      ip.ipv4?
    rescue IPAddr::InvalidAddressError => e
      false
    end

    # Validates if a string matches a comma-seperated file
    def is_valid_csv?(part)
      part =~ /#{Mergeit::Config::CSV_FORMAT[:regex]}/
    end

    # Used to split a line with a set delimeter and maximum split size
    def split_line(line)
      line.split(Mergeit::Config::FILE_FORMAT[:delimeter], Mergeit::Config::SUPPORTED_PARTS[:size])
    end

    # Used to store values in an existing key of a hash
    def store_values_in_existing_key(ip, numbers)
      numbers.each { |number|
        @hash_of_merged_data[ip] << number
      }
    end

    # Store new key and values in the hash
    def store_new_key_and_values(ip, numbers)
      @hash_of_merged_data.store(ip, numbers)
    end

    # Logic for determining if existing key or new
    def process_to_hash(ip, numbers)
      if @hash_of_merged_data.has_key?(ip)
        store_values_in_existing_key(ip, numbers)
      else
        @hash_of_merged_data.store(ip, numbers)
      end
    end

    # To Float or To Integer
    def to_float_or_int(v)
      v.match('\.').nil? ? Integer(v) : Float(v)
    end

    # Sanitize the hash by removing duplicates and sorting
    def sanitize_hash
      @hash_of_merged_data.map { |key,values|
        values.map! {|value| to_float_or_int(value) }
        values.uniq!
        values.sort!
        { key => values }
      }.reduce(:merge)
    end

    # Open a file and for each line, get the IP and numbers \n
    # and merge into Hash
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

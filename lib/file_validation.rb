module Mergeit
  # Used to Validate The Input Files
  class FileValidation
    attr_accessor :errors

    def initialize(input_files)
      @errors = []
      @input_files = input_files
    end

    # Checks if the files actually exist at the specified location
    def files_exist?
      exist_errors = check_if_files_exist
      exist_errors.each {|error| @errors << error } unless exist_errors.empty?
      @errors.empty?
    end

    # Checks if the files are actual text files
    def files_are_ascii?
      ascii_errors = check_if_files_ascii
      ascii_errors.each {|error| @errors << error } unless ascii_errors.empty?
      @errors.empty?
    end

    # Supporting method that actual does the word for a files existence
    def check_if_files_exist
      result = []
      @input_files.each { |filename|
        result << "#{filename} does not exist" unless File.exist?(filename)
      }
      result
    end

    # Supporting method that checks if a file is ascii
    def check_if_files_ascii
      result = []
      @input_files.each { |filename|
        file_type = %x[ file #{filename} ]
        result << "#{filename} not ascii" unless file_type =~ /ascii/i
      }
      result
    end
  end
end

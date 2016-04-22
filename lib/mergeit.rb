require "mergeit/version"

module Mergeit
  class Merge
    attr_reader :input_files, :errors

    def initialize(input_files)
      @errors = []
      @input_files = input_files
      print_errors_and_exit unless validate_input_files
    end

    protected
    def print_errors_and_exit
      @errors.each { |error| puts error }
      exit
    end

    def validate_input_files
      validate_files_exist && validate_files_ascii
    end

    private
    def validate_files_exist
      exist_errors = check_if_files_exist
      exist_errors.each {|error| @errors << error } unless exist_errors.empty?
      @errors.empty?
    end

    def validate_files_ascii
      ascii_errors = check_if_files_ascii
      ascii_errors.each {|error| @errors << error } unless ascii_errors.empty?
      @errors.empty?
    end

    def check_if_files_exist
      result = []
      @input_files.each { |filename|
        result << "#{filename} does not exist" unless File.exist?(filename)
      }
      result
    end

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

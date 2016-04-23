require "mergeit/version"
require "file_validation"
require "merge_data"

module Mergeit
  # Interface to the Command Line Application (/bin/mergeit)
  # @note Entry-point into the actual merge process
  class Merge
    attr_reader :input_files

    # Custom error 
    class MergeError < StandardError; end

    def initialize(input_files)
      @errors = []
      @input_files = input_files
      raise_error unless validate_input_files
      @mergeit = Mergeit::MergeData.new
    end

    # Main public method that fires the merge process. \n
    # Returns a sanitized hash that is unique and sorted ascending
    def merge
      @mergeit.merge_data(@input_files)
    end

    protected

    # Validates the Files prior to use
    def validate_input_files
      file_validation = FileValidation.new(input_files)
      raise_error(file_validation.errors) unless file_validation.files_exist? 
      raise_error(file_validation.errors) unless file_validation.files_are_ascii?
      true
    end

    private

    # Used to raise Exceptions
    def raise_error(errors)
      raise MergeError.new(errors.join(","))
    end


  end
end

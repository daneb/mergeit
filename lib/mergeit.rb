require "mergeit/version"
require "file_validation"
require "merge_data"

module Mergeit
  class Merge
    attr_reader :input_files

    class MergeError < StandardError; end

    def initialize(input_files)
      @errors = []
      @input_files = input_files
      raise_error unless validate_input_files
      @mergeit = Mergeit::MergeData.new
    end

    def merge
      @mergeit.merge_data(@input_files)
    end

    protected

    def validate_input_files
      file_validation = FileValidation.new(input_files)
      raise_error(file_validation.errors) unless file_validation.files_exist? 
      raise_error(file_validation.errors) unless file_validation.files_are_ascii?
      true
    end

    private

    def raise_error(errors)
      raise MergeError.new(errors.join(","))
    end


  end
end

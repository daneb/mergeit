class FileValidation
  attr_accessor :errors

  def initialize(input_files)
    @errors = []
    @input_files = input_files
  end

  def files_exist?
    exist_errors = check_if_files_exist
    exist_errors.each {|error| @errors << error } unless exist_errors.empty?
    @errors.empty?
  end

  def files_are_ascii?
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

require 'byebug'

class MergeTest
  attr_reader :incorrect_stdout

  VALID_BANNER = "usage: bin/mergeit [options]\n    -f1, --file1   First source file\n    -f2, --file2   Second source file\n    -v, --version  \n"

  def app
    "bin/mergeit"
  end

  def application_with_incorrect_option_name
    "#{app} -p1 hello.txt -p2 world.txt"
  end

  def application_with_no_first_file
    "#{app} -f1 hello.txt -f2"
  end

  def application_with_no_second_file
    "#{app} -f1 -f2 hello.txt"
  end

  def execute_without_arguments
    @stdout = %x[#{app}]
    true
  rescue Exception => e
    false
  end

  def use_incorrect_option_name
    @incorrect_stdout = %x[#{application_with_incorrect_option_name}]
    true
  rescue Exception => e
    false
  end

  def use_only_one_argument
    @incorrect_stdout = %x[ #{app} -f1 test.txt ]
    true
  rescue Exception => e
    false
  end

  def only_input_second_filename
    @incorrect_stdout = %x[ #{ application_with_no_first_file }]
    true
  rescue Exception => e
    false
  end

  def only_input_first_filename
    @incorrect_stdout = %x[ #{application_with_no_second_file} ]
    true
  rescue Exception => e
    false
  end

  def help_information_is_printed
    @stdout == VALID_BANNER
  end

  def notified_with_unknown_option
    @incorrect_stdout == "unknown option `-p'\n"
  end

  def notified_missing_argument
    @incorrect_stdout.include?('missing argument')
  end

  def notified_missing_filenames
    @incorrect_stdout.include?('both filenames are required')
  end

end

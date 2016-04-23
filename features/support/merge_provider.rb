require 'byebug'

class MergeTest
  attr_reader :incorrect_stdout

  VALID_BANNER = "usage: bin/mergeit [options]\n    -f1, --file1   First source file\n    -f2, --file2   Second source file\n    -v, --version  \n"
  VALID_MERGE = "1.2.3.4: 1,3,4,5,6\n1.2.3.5: 6,7,8,9\n1.2.3.6: 1\n"

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

  def application_with_no_second_option
    "#{app} -f1 hello.txt"
  end

  def application_with_valid_options_and_arguments
    "#{app} -f1 features/support/file1.txt -f2 features/support/file2.txt"
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

  def execute_correctly
    @stdout = %x[#{ application_with_valid_options_and_arguments }]
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

  def only_first_option_and_first_filename
    @incorrect_stdout = %x[ #{application_with_no_second_option} ]
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

  def final_result
    @stdout == VALID_MERGE 
  end

end

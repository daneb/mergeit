require 'byebug'

class MergeTest
  attr_reader :incorrect_stdout

  VALID_BANNER = "usage: bin/mergeit [options]\n    -f1, --file1   First source file\n    -f2, --file2   Second source file\n    -v, --version  \n"

  def application
    "bin/mergeit"
  end

  def application_with_incorrect_option_name
    "#{application} -p1 hello.txt -p2 world.txt"
  end

  def application_with_no_second_file
    "#{application} -f1 hello.txt -f2"
  end

  def execute_without_arguments
    @stdout = %x[ #{application} ]
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
    @incorrect_stdout = %x[ #{application} -f1 test.txt ]
    true
  rescue Exception => e
    false
  end

  def dont_use_second_filename
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

end
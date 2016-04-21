require 'byebug'

class MergeTest
  attr_reader :stdout, :incorrect_stdout

  def application
    "bin/mergeit"
  end

  def execute_application_without_arguments
    @stdout = %x[ #{application} ]
    true
  rescue Exception => e
    false
  end

  def help_information_is_printed
    help_banner = "usage: bin/mergeit [options]\n    -f1, --file1   First source file\n    -f2, --file2   Second source file\n    -v, --version  \n"
    @stdout == help_banner
  end

  def use_only_one_argument
    @incorrect_stdout = %x[ #{application } -f1 test.txt ]
  end
end
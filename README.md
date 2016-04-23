# Mergeit
[![Build Status](https://travis-ci.org/daneb/mergeit.svg?branch=master)](https://travis-ci.org/daneb/mergeit)
#### Custom-format merge utility

#### Current Format Support of Input Files
- [ IP ] : [ CSV format numbers ]
- 127.0.0.1: 1,202,3,4
- 192.168.101.1: 32,23,100

#### There is flexibility in the format, please review lib/config.rb
``` ruby
    # Delimiter for how a line is divided up into parts
    FILE_FORMAT = { delimeter: ':'}
    # Determines after splitting on delimeter how many parts there should be
    SUPPORTED_PARTS = { size: 2 }
    # Regex that verfies a CSV (supports floating-point and integers) 
    # @note Does not support e notation
    CSV_FORMAT = { regex: '(^((\d+,)|(\d+[,.]\d+))+(\d+|(\d+[,.]\d+))$)' }
    # Delimiter for splitting the second part (aka. the numbers)
    NUMBERS = { delimeter: ','}
```
#### Get Started
**RVM and Ruby 2.3.0 are required dependencies** <br />
1. Clone Repo<br>
2. gem install bundler<br>
3. bundle install<br>

#### How To Run Tests
_Run both cucumber and rspec tests (default configured)_ <br />
\# rake <br>
**Further info view Rakefile in project root**<br />

#### Code Coverage
_HTML report can be found coverage/index.html_<br />
\# rake mergeit:coverage<br />

#### Run Command Line Executable
_Help_<br>
\# bin/mergeit<br> 
_Example_<br>
\# bin/mergeit -f1 file1.txt -f2 file2.txt<br>

#### Documentation
_Generate documentation_<br>
\# yard doc<br>
_Host documentation locally_<br>
\# yard server<br>

#### Extra-reading (initial planning and scratch)
[ Google Doc ] (https://docs.google.com/spreadsheets/d/1CXo1Y-cEUk6f4TTWWvIPyYmfL5y0Tz_zy2ahPy-eqc4/edit?usp=sharing)
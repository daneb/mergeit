module Mergeit
  # Using Ruby For Configuration
  module Config
    # Delimiter for how a line is divided up into parts
    FILE_FORMAT = { delimeter: ':'}
    # Determines after splitting on delimeter how many parts there should be
    SUPPORTED_PARTS = { size: 2 }
    # Regex that verfies a CSV (supports floating-point and integers) 
    # @note Does not support e notation
    CSV_FORMAT = { regex: '(^((\d+,)|(\d+[,.]\d+))+(\d+|(\d+[,.]\d+))$)' }
    # Delimiter for splitting the second part (aka. the numbers)
    NUMBERS = { delimeter: ','}
  end
end

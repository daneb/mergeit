module Mergeit
  module Config
    FILE_FORMAT = { delimeter: ':'}
    SUPPORTED_PARTS = { size: 2 }
    CSV_FORMAT = { regex: '(^((\d+,)|(\d+[,.]\d+))+(\d+|(\d+[,.]\d+))$)' }
  end
end

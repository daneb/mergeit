@hash = {}

def process_to_hash(ip, numbers)
  if @hash.has_key?(ip)
    numbers.each { |number|
      @hash[ip] << number
    }
  else
    @hash.store(ip, numbers)
  end
end

# To Float or To Integer
def to_float_or_int(v)
    v.match('\.').nil? ? Integer(v) : Float(v) 
end

def sanitize_hash
  result = @hash.map { |key,values|
    values.uniq!
    values.sort!
    values.map! {|value| to_float_or_int(value) }
  }
  result
end

for file in (['./file1.txt', './file2.txt']) do
    f = File.open(file, 'r')
    f.each_line { |line|
      pair = line.split(':')
      ip = pair[0].strip
      numbers = pair[1].strip.split(',')
      process_to_hash(ip, numbers)
    }
    f.close
end

sanitize_hash

puts @hash

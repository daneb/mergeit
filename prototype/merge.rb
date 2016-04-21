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

def sanitize_hash
  @hash.map { |key,value|
    value.uniq!
    value.sort!
  }
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

puts @hash.inspect

require 'spec_helper'
require 'byebug'

describe Mergeit::MergeData do
  before :each do
    @file1 = 'spec/support/file1.txt'
    @file2 = 'spec/support/file2.txt'
    @file_inputs = [@file1, @file2]
    @mergeit = Mergeit::MergeData.new
    Mergeit::MergeData.send(:public, *Mergeit::MergeData.private_instance_methods)
  end

  context 'Open files individually' do
    it 'should open the file for read' do
      fh = @mergeit.open_file(@file1)
      expect(fh.closed?).to be false
    end

    it 'should iterate over both files' do
      expect(@mergeit.merge_data(@file_inputs).inspect).to eq "{\"1.2.3.4\"=>[1, 3, 4, 5, 6], \"1.2.3.5\"=>[6, 7, 8, 9], \"1.2.3.6\"=>[1]}"
    end
  end

  context 'Validate the line of each file' do
    it 'should split the line' do
      line = '192.168.7.11: 1,2,3,45'
      expect(@mergeit.split_line(line).length).to eq Mergeit::Config::SUPPORTED_PARTS[:size]
    end

    it 'should not split the line if it does not contain pre-defined delimeter' do
      line = '192.168.7.11 1,2,3,45'
      expect(@mergeit.split_line(line).length).not_to eq Mergeit::Config::SUPPORTED_PARTS[:size]
    end

    it 'should not split the line if there is more than one ' do
      line = '192.168.7.11: 12,:.34,4,6'
      expect(@mergeit.split_line(line).length).to eq Mergeit::Config::SUPPORTED_PARTS[:size]
    end

    it 'should check if the first part is an IP address' do
      partA = "127.0.0.1"
      expect(@mergeit.is_ip_addr?(partA)).to eq true
    end

    it 'should indicate if the first part is not an IP address' do
      partA = "127.256.0.1"
      expect(@mergeit.is_ip_addr?(partA)).to eq false
    end

    it 'should validate if the second part is in CSV format' do
      partB = "1,2,3,4,5000,123234"
      expect(@mergeit.is_valid_csv?(partB)).to eq 0
    end

    it 'should fail validation as csv if letters in the sequence' do
      part_front = "AAA1,2,3,4,5"
      part_within = "1000,2344,54353,ABC,312313,12,3,4"
      part_end = "123,3,4,5777777777788899999999999999999999,223232a"
      expect(@mergeit.is_valid_csv?(part_front)).to eq nil
      expect(@mergeit.is_valid_csv?(part_within)).to eq nil
      expect(@mergeit.is_valid_csv?(part_end)).to eq nil
    end

    it 'should fail to validate as csv if there are any symbols in the sequence' do
      part_front = "#\{\!\@\#\}1,2,3,4,5"
      part_within = "1000,2344,54353,^$%,312313,12,3,4"
      part_end = "123,3,4,5777777777788899999999999999999999,2%#$%"
      expect(@mergeit.is_valid_csv?(part_front)).to eq nil
      expect(@mergeit.is_valid_csv?(part_within)).to eq nil
      expect(@mergeit.is_valid_csv?(part_end)).to eq nil
    end

    it 'should support floating points but without e notation' do
      part_front = "1.123241,2,3,4,5"
      part_within = "1000,2344,54353,54244242342.342342,312313,12,3,4"
      part_end = "123,3,4,5777777777788899999999999999999999,24242342342342342342342.1"
      expect(@mergeit.is_valid_csv?(part_front)).to eq 0
      expect(@mergeit.is_valid_csv?(part_within)).to eq 0
      expect(@mergeit.is_valid_csv?(part_end)).to eq 0
    end
  end

  context 'merging data into hash' do
    it 'should insert the key and values if the key does not already exist' do
      @mergeit.hash_of_merged_data = {}
      @mergeit.hash_of_merged_data.store('127.0.0.1', ['1','2','3','4','5'])
      @mergeit.process_to_hash('127.0.0.1', ['6','7','8'])
      expect(@mergeit.hash_of_merged_data['127.0.0.1']).to eq ["1", "2", "3", "4", "5", "6", "7", "8"]
    end

    it 'should append the values if the key does exist' do
      @mergeit.hash_of_merged_data = {}
      @mergeit.process_to_hash('127.0.0.1', ['1','2','3','4','5'])
      expect(@mergeit.hash_of_merged_data['127.0.0.1']).to eq ['1','2','3','4','5']
    end

    it 'should detect a string as a float and convert it' do
      value = '12.42352352352'
      expect(@mergeit.to_float_or_int(value).class).to eq Float
    end

    it 'should detect a string as an int and convert it' do
      value = '12345678880000'
      expect(@mergeit.to_float_or_int(value).class).to eq Fixnum
    end

    it 'should sanitize the hash of merged data to be sorted' do
      @mergeit.hash_of_merged_data = {}
      @mergeit.process_to_hash('127.0.0.1', ['1','100','2','1','1'])
      expect(@mergeit.sanitize_hash.inspect).to eq "{\"127.0.0.1\"=>[1, 2, 100]}"
    end

    it 'should sanitize the hash of merged data to have no duplicates' do
      @mergeit.hash_of_merged_data = {}
      @mergeit.process_to_hash('192.168.7.1', ['100','1','2','3','4','6','6','7'])
      expect(@mergeit.sanitize_hash.inspect).to eq  "{\"192.168.7.1\"=>[1, 2, 3, 4, 6, 7, 100]}"
    end
  end
end

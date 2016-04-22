require 'spec_helper'
require 'byebug'

describe Mergeit::MergeData do
  before :each do
    @file1 = 'spec/support/file1.txt'
    @file2 = 'spec/support/file2.txt'
    @file_inputs = [@file1, @file2]
    @merge_data = Mergeit::MergeData.new
    Mergeit::MergeData.send(:public, *Mergeit::MergeData.private_instance_methods)
  end

  context 'Open files individually' do
    it 'should open the file for read' do
      fh = @merge_data.open_file(@file1)
      expect(fh.closed?).to be false
    end
  end

  context 'Validate the line of each file' do
    it 'should split the line' do
      line = '192.168.7.11: 1,2,3,45'
      expect(@merge_data.split_line(line).length).to eq Mergeit::Config::SUPPORTED_PARTS[:size]
    end

    it 'should not split the line if it does not contain pre-defined delimeter' do
      line = '192.168.7.11 1,2,3,45'
      expect(@merge_data.split_line(line).length).not_to eq Mergeit::Config::SUPPORTED_PARTS[:size]
    end

    it 'should not split the line if there is more than one ' do
      line = '192.168.7.11: 12,:.34,4,6'
      expect(@merge_data.split_line(line).length).to eq Mergeit::Config::SUPPORTED_PARTS[:size]
    end

    it 'should check if the first part is an IP address' do
      partA = "127.0.0.1"
      expect(@merge_data.is_ip_addr?(partA)).to eq true
    end

    it 'should indicate if the first part is not an IP address' do
      partA = "127.256.0.1"
      expect(@merge_data.is_ip_addr?(partA)).to eq false
    end

    it 'should validate if the second part is in CSV format' do
      partB = "1,2,3,4,5000,123234"
      expect(@merge_data.is_valid_csv?(partB)).to eq 0
    end

    it 'should fail validation as csv if letters in the sequence' do
      part_front = "AAA1,2,3,4,5"
      part_within = "1000,2344,54353,ABC,312313,12,3,4"
      part_end = "123,3,4,5777777777788899999999999999999999,223232a"
      expect(@merge_data.is_valid_csv?(part_front)).to eq nil
      expect(@merge_data.is_valid_csv?(part_within)).to eq nil
      expect(@merge_data.is_valid_csv?(part_end)).to eq nil
    end

    it 'should fail to validate as csv if there are any symbols in the sequence' do
      part_front = "#\{\!\@\#\}1,2,3,4,5"
      part_within = "1000,2344,54353,^$%,312313,12,3,4"
      part_end = "123,3,4,5777777777788899999999999999999999,2%#$%"
      expect(@merge_data.is_valid_csv?(part_front)).to eq nil
      expect(@merge_data.is_valid_csv?(part_within)).to eq nil
      expect(@merge_data.is_valid_csv?(part_end)).to eq nil
    end

    it 'should support floating points but without e notation' do
      part_front = "1.123241,2,3,4,5"
      part_within = "1000,2344,54353,54244242342.342342,312313,12,3,4"
      part_end = "123,3,4,5777777777788899999999999999999999,24242342342342342342342.1"
      expect(@merge_data.is_valid_csv?(part_front)).to eq 0
      expect(@merge_data.is_valid_csv?(part_within)).to eq 0
      expect(@merge_data.is_valid_csv?(part_end)).to eq 0
    end
  end

  context 'merging data into hash' do
    it 'should insert the key and values if the key does not already exist' do
      @merge_data.hash_of_merged_data = {}
      @merge_data.hash_of_merged_data.store('127.0.0.1', ['1','2','3','4','5'])
      @merge_data.store_values_in_existing_key('127.0.0.1', ['6','7','8'])
      expect(@merge_data.hash_of_merged_data['127.0.0.1']).to eq ["1", "2", "3", "4", "5", "6", "7", "8"]
    end

    it 'should append the values if the key does exist' do
      @merge_data.hash_of_merged_data = {}
      @merge_data.store_new_key_and_values('127.0.0.1', ['1','2','3','4','5'])
      expect(@merge_data.hash_of_merged_data['127.0.0.1']).to eq ['1','2','3','4','5']
    end

  end
end

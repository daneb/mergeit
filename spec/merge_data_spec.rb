require 'spec_helper'
require 'byebug'

describe Mergeit::MergeData do
  before :each do
    @file1 = 'spec/support/file1.txt'
    @file2 = 'spec/support/file2.txt'
    @file_inputs = [@file1, @file2]
    @merge_data = Mergeit::MergeData
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
      expect(@merge_data.split_line(line).length).to eq 2
    end

    it 'should not split the line if it does not contain pre-defined delimeter' do
      line = '192.168.7.11 1,2,3,45'
      expect(@merge_data.split_line(line).length).to eq 1
    end

    it 'should not split the line if there is more than one ' do
    end
  end

  context 'Check if key exists' do
  end

  context 'Insert new key value pair' do
  end

  context 'Append to existing key the new values' do
  end

  context 'Remove duplicates from all values for each key' do
  end

  context 'Sort all values for each key' do
  end

end

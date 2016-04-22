require 'spec_helper'
require 'byebug'

describe Mergeit::MergeData do
  before :each do
    @file1 = 'spec/support/file1.txt'
    @file2 = 'spec/support/file2.txt'
    @iut = Mergeit::MergeData.new([@file1, @file2])
  end

  context 'initialize' do
    it 'should initialize with input array of two files' do
      expect(@iut.input_files).to eq [@file1, @file2]
    end
  end

  context 'Open files individually' do
  end

  context 'Validate the line of each file' do
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

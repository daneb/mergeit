require 'spec_helper'

 describe Mergeit::Merge do
  before :each do
    @file1 = 'spec/support/file1.txt'
    @file2 = 'spec/support/file2.txt'
    @iut = Mergeit::Merge.new([@file1, @file2])

    # Send Protected Methods to Public
    Mergeit::Merge.send(:public, *Mergeit::Merge.protected_instance_methods)
  end

  context 'Initialization' do
    it 'should receive an array with two files' do
      expect(@iut.input_files == [@file1, @file2]).to be true
    end

    it 'should validate that the input is an array' do
      expect(@iut.input_files.class == Array).to eq true 
    end

    it 'should check the files exists' do
      expect(@iut.validate_input_files).to eq true
    end

    it 'should notify if any or both files do not exist' do
      dud_file_iut = Mergeit::Merge.new([@file1, '/etc/hostages'])
      expect(dud_file_iut.validate_input_files).to eq ["/etc/hostages does not exist"]
    end

    it 'should confirm if the files are ASCII' do
      expect(@iut.validate_input_files).to be true
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

  context 'Print result to stdout' do
    
  end
end
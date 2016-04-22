require 'spec_helper'
require 'byebug'

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
      expect{Mergeit::Merge.new([@file1, '/etc/hostages'])}.to raise_error(Mergeit::Merge::MergeError, '/etc/hostages does not exist')
    end

    it 'should confirm if the files are ASCII' do
      expect(@iut.validate_input_files).to be true
    end

    it 'should notify if any or both files are not ASCII' do
      errors = '/bin/cat not ascii,/bin/cp not ascii'
      expect{Mergeit::Merge.new(['/bin/cat', '/bin/cp'])}.to raise_error(Mergeit::Merge::MergeError, errors)
    end
  end

  context 'Print result to stdout' do
    
  end
end
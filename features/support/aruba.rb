require 'aruba/cucumber'

Before do |scenario|
  begin
    @test = MergeTest.new
  rescue
    Cucumber.wants_to_quit = true
    raise
  end
end

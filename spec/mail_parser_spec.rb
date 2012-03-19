require "spec_helper.rb"

describe MailParser do
  it "should able to parse" do
    parser = MailParser.new

    parser.parse "Test :: 1" do |m|
      m.match /Test/, /(\d)/ ,:value
    end

    parser.data[:value].should == "1"
  end
end

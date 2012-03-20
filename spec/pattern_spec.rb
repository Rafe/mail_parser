require "spec_helper.rb"

describe Pattern do 
  it "can inject to parser" do 
    parser = MailParser.new(Pattern.new)

    parser.parse "TEST :: 12"

    parser.data.should == {:price => "12"}
  end
end

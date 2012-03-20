require "spec_helper.rb"

describe AmazonPattern do 
  before do
    path = File.join(File.dirname(__FILE__),"samples/amazon_order.html")
    @mail = File.open(path).read
    @parser = MailParser.new(AmazonPattern.new)
  end

  it "can inject to parser" do 
    @parser.parse @mail
    @parser.data.should == 
      {:shipping => "3.99", :total_price=>"9.54", :items=>[{:name=>"The Curious Cook: More Kitchen Science and Lore", :price=>"5.55"}]}
  end
end

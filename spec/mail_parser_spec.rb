require "spec_helper.rb"

describe MailParser do
  before do
    @parser = MailParser.new
  end
  it "should able to parse" do

    @parser.parse "Test :: 1" do |m|
      m.match :value, /Test/, /(\d)/
    end

    @parser.data[:value].should == "1"
  end

  it "can trim html tags" do

    @parser.parse "<html> <head> Test :: $12</head> </html>", :html do |m|
      m.match :tag, /\<.*\>/, /\<\/(.*)\>/
    end

    @parser.data[:tag].should be_nil
  end

  it "can match multiple items" do

    @parser.parse "test :1 \n test :2 \n END", :html do |m|
      m.parse_until :items, /END/ do |m|
        m.match :price, /test/, /(\d+)/
      end
    end

    @parser.data.should == {:items => [{price: "1"},{price: "2"}]}
  end

  it "can stop at curtain line" do
    @parser.parse "test :1 \n END \n test :2" do |m|
      m.parse_until :items, /END/ do |m|
        m.match :price, /test/, /(\d+)/
      end
    end

    @parser.data.should == {:items => [{price: "1"}]}

  end

  it "can match single line" do

    @parser.parse "Test :1" do |m|
      m.match :number , /:(\d)/
    end

    @parser.data.should == {:number => "1"}
  end

  describe "Amazon order" do

    before do
      path = File.join(File.dirname(__FILE__),"samples/amazon_order.html")
      @mail = File.open(path).read
    end

    it "can parse Amazon order mail" do

      @parser.parse @mail do |m|
        m.match :email, /E-mail/,/(\w+@\w+\.\w+)/
      end

      @parser.data.should == {email: "test@example.com"}
    end

    it "can extracts items" do
      @parser.parse @mail do |m|
        m.parse_until :items , /Need to give a gift?/ do |m|
          m.match :name, /\d\s"(.*)"/
          m.match :price, /\$(\d+\.*\d*)/
        end
      end
      
      @parser.data.should == {:items => [
        {:name => "The Curious Cook: More Kitchen Science and Lore", :price => "5.55"}]}
    end
  end
end

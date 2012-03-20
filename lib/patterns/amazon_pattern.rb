class AmazonPattern
  attr_accessor :block
  def initialize
    @block = lambda do |m|
      m.match :shipping , /Shipping & Handling/, /\$(\d+\.\d+)/
      m.match :total_price, /Total for this Order/, /\$(\d+\.\d+)/

      m.match_until :items, /\*{10}/ do |m|
        m.match :name, /\d+/, /"(.*)"/
        m.match :price, /\$(\d+\.\d+)/
      end
    end
  end
end

class Pattern
  attr_accessor :block

  def initialize
    @block = lambda do |m|
      m.match :price , /(\d+)/
    end
  end
end

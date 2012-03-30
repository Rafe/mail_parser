class MailParser
  attr_accessor :body, :data, :index, :pattern, :stop

  def initialize(pattern=nil)
    @pattern = pattern
  end

  def truncate_html(html)
    html.gsub(/<.*>/,"")
  end

  def parse(body, *options, &block)
    body = truncate_html(body) if options.include? :html

    @body = body.split("\n") 
    @index = 0
    @data = {}

    if block_given?
      yield self
    end

    #call the injected pattern
    if !@pattern.nil? && @pattern.respond_to?(:block)
      @pattern.block.call self
    end

    @data
  end

  def match(field, *patterns)
    pattern = patterns[0]
    if patterns.length == 2
      invoked = false
      target_pattern = patterns[1]
    else
      invoked = true
      target_pattern = pattern
    end

    @body[@index..@body.length].each do |line|
      if @stop && line =~ @stop
        throw :halt
      end
      if !invoked && line =~ pattern
        invoked = true
      end
      if invoked && line =~ target_pattern
        @data[field] = target_pattern.match(line)[1]
        @index += 1
        return
      end
      @index += 1
    end
  end 

  def parse_until(field,pattern)
    data = @data.clone
    collections = []
    begin
      @data = {}
      @stop = pattern
      catch(:halt) do
        yield self if block_given?
      end
      @stop = nil
      collections << @data if @data != {}
    end until @body[@index] =~ pattern or @index >= @body.length
    @data = data.merge({field => collections })
  end

  alias :match_until :parse_until
end

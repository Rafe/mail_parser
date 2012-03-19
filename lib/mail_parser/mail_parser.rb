class MailParser
  attr_accessor :body, :data

  def truncate_html(html)
    html.gsub(/<.*>/,"")
  end

  def parse(body, *options, &block)
    if options.include? :html
      body = truncate_html(body)
    end
    @body = body.split("\n") 
    @index = 0
    @data = {}

    if block_given?
      yield self
    end
  end

  def match(pattern,target_pattern,field)
    invoked = false
    for line in @body[@index..@body.length] 
      if !invoked and line =~ pattern
        invoked = true
      end
      if invoked and line =~ target_pattern
        @data[field] = target_pattern.match(line)[1]
        return
      end
      @index += 1
    end
  end
end

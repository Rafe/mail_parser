# Mail Parser

A simple text parser using regex 

##Example::

    mail = <<- HTML
      Title:: "Some mail"
      send by example@mail.com
      Item:: 1 "Some item"
      Item:: 2 "Some item"
      Thanks
    HTML

    parser = MailParser.new

    parser.parse mail do |m|

      #match by prefix
      m.match :title , /Title:/ , / "(.*)"/

      #match single regex
      m.match :email , /(\w+@\w+\.\w+)/

      #match multiple items
      m.match_until :items, /Thanks/ do |m|
        m.match :item , /"(,*)"/
      end

    end

require 'erb'

include ERB::Util

def section id
  item = @items["/#{id.to_s}.*"]
  <<-HTML
<section markdown="block">
#{item.raw_content}
</section>
  HTML
end

def person name, website, profile
  if not website
    name
  elsif not profile
    <<-HTML
<a href="#{website}">#{name}</a>
    HTML
  else
    <<-HTML
<a href="#{website}" typeof="http://xmlns.com/foaf/0.1/Person" resource="#{profile}">#{name}</a>
    HTML
end
end
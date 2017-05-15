require 'erb'
include ERB::Util

CSL::Style.root = File.dirname(__FILE__)

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
    h name
  elsif not profile
    %{<a href="#{h website}">#{h name}</a>}
  else
    %{<a href="#{h website}" typeof="http://xmlns.com/foaf/0.1/Person" resource="#{profile}">#{h name}</a>}
  end
end

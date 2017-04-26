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

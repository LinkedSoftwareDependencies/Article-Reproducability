class MarkupFilter < Nanoc::Filter
  identifier :markupfilter

  def run(content, params = {})
    content = content.dup

    # Move references into <main>
    references = content[%r{<h2 id="references">.*?</dl>}m]
    content[references] = ''
    content['</main>'] = "<section>\n" + references + "\n</section>\n</main>"

    # Move IDs on headings to parent sections
    content.gsub! /<section>(\s*)(<h\d[^>]*)(\sid=[^\s>]+)/,
                  '<section\3>\1\2'

    # Build labels by ID
    @reference_counts = {}
    labels = content.scan(/<(\w+)([^>]*\s+id="([^"]+)"[^>]*)>/)
                    .map do |tag, attribute_list, id|
      type = reference_type_for tag.downcase.to_sym, attribute_list
      number = (reference_counts[type] || 0) + 1
      reference_counts[type] = number
      [id, "#{type} #{number}"]
    end
    labels = labels.to_h

    # Add labels to text
    content.gsub! %r{(<a href="#([^"]+)">)(</a>)} do |match|
      if labels.key? $2
        "#{$1}#{h labels[$2]}#{$3}"
      else
        match
      end
    end

    # Include code blocks
    content.gsub! %r{````(/[^`]+)````} do
      code = @items[$1]
      raise "Code block #{$1} not found." unless code
      "<pre><code>#{h code.raw_content}</code></pre>"
    end

    content
  end

  def reference_type_for tag, attributes
    case tag
    when :figure
      'Fig.'
    else
      'Unknown'
    end
  end
end

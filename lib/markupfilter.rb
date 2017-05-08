Nanoc::Filter.define(:markupfilter) do |content, params|
  content = content.dup

  # Move references into <main>
  references = content[%r{<h2 id="references">.*?</dl>}m]
  content[references] = ''
  content['</main>'] = "<section>\n" + references + "\n</section>\n</main>"

  # Move IDs on headings to parent sections
  content.gsub! /<section>(\s*)(<h\d[^>]*)(\sid=[^\s>]+)/,
                '<section\3>\1\2'

  # Include code blocks
  content.gsub! %r{````(/[^`]+)````} do
    code = @items[$1]
    raise "Code block #{$1} not found." unless code
    "<pre><code>#{h code.raw_content}</code></pre>"
  end

  content
end

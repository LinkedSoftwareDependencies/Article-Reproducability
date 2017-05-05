Nanoc::Filter.define(:markupfilter) do |content, params|
  content = content.dup

  # Move references into <main>
  references = content[%r{<h2 id="references">.*?</dl>}m]
  content[references] = ''
  content['</main>'] = "<section>\n" + references + "\n</section>\n</main>"

  # Move IDs on headings to parent sections
  content.gsub! /<section>(\s*)(<h\d[^>]*)(\sid=[^\s>]+)/,
                '<section\3>\1\2'

  content
end

Nanoc::Filter.define(:markupfilter) do |content, params|
  # Move IDs on headings to parent sections
  content = content.gsub /<section>(\s*)(<h\d[^>]*)(\sid=[^\s>]+)/,
                         '<section\3>\1\2'
end

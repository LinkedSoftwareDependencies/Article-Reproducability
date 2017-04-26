require 'bibmarkdown'
require 'bibtex'
require 'csl/styles'

Nanoc::Filter.define(:bibmarkdown) do |content, params|
  entries = BibTeX.parse(params[:bibfile].raw_content).entries
  entries.each_value { |e| e.convert!(:latex) { |key| key != :url } }
  params = params.merge(entries: entries)
  BibMarkdown::Document.new(content, params).to_markdown
end

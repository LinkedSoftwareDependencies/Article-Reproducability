class MarkupFilter < Nanoc::Filter
  identifier :markupfilter

  def run(content, params = {})
    content = content.dup

    hyphenate_iris content

    include_code_blocks content

    labels = create_labels content
    add_labels_to_figures content, labels
    set_reference_labels content, labels

    move_footnotes_to_footer content
    move_references_to_footer content
    move_heading_ids_to_section content

    content
  end

  # Hyphenate long IRIs
  def hyphenate_iris content
    # Replace in-text URLs
    content.gsub! %r{>https?://[^>]+?} do |match|
      hyphenate(match)
    end
    # Replace mandatory links
    content.gsub! %r{<a href="([^"]+)"[^>]*\s+class="mandatory"} do |match|
      %{#{match} data-link-text="#{hyphenate $1}"}
    end
  end

  # Add zero-width space after slashes and hyphens to allow hyphenation
  def hyphenate text
    text.gsub %r{(?<=/|-)}, "\u200B"
  end

  # Moves IDs on headings to their parent section
  def move_heading_ids_to_section content
    content.gsub! /<section>(\s*)(<h\d[^>]*)(\sid=[^\s>]+)/,
                  '<section\3>\1\2'
  end

  # Move the footnotes to the footer
  def move_footnotes_to_footer content
    container = content[%r{<div class="footnotes">\s*(.*?)\s*</div>}m]
    if container
      footnotes = $1
      content[container] = ''
      content['</footer>'] =  <<-FOOTER
        <section id="footnotes">
          <h2>Footnotes</h2>
          #{footnotes}
        </section>
      </footer>
      FOOTER
    end
  end

  # Moves the references section into <footer>>
  def move_references_to_footer content
    references = content[%r{<h2 id="references">.*?</dl>}m]
    if references
      content[references] = ''
      content['</footer>'] = "<section>\n" + references + "\n</section>\n</footer>"
    end
  end

  # Includes code blocks from external files
  def include_code_blocks content
    content.gsub! %r{````(/[^`]+)````} do
      code = @items[$1]
      raise "Code block #{$1} not found." unless code
      "<pre><code>#{h code.raw_content}</code></pre>"
    end
  end

  # Creates labels for referenceable elements
  def create_labels content
    @reference_counts = {}
    main = content[%r{<main>.*</main>}m]
    labels = main.scan(/<(\w+)([^>]*\s+id="([^"]+)"[^>]*)>/)
                 .map do |tag, attribute_list, id|
      type = label_type_for tag.downcase.to_sym, attribute_list
      number = number_for type
      [id, "#{type} #{number}"]
    end
    labels.to_h
  end

  # Determines the label type of a given element
  def label_type_for tag, attribute_list
    case tag
    when :h2
      'Section'
    when :h3
      'Subsection'
    when :figure
      case parse_attributes(attribute_list)[:class]
      when 'listing'
        'Listing'
      else
        'Fig.'
      end
    else
      'Unknown'
    end
  end

  def number_for type
    # Determine number of elements
    @reference_counts[type] ||= 0
    number = @reference_counts[type] += 1

    # Perform hierarchical numbering when needed
    case type
    when 'Section'
      @reference_counts['Subsection'] = 0
    when 'Subsection'
      number = "#{reference_counts['Section']}.#{number}"
    end
    number
  end

  # Adds labels to referenceable figures
  def add_labels_to_figures content, labels
    content.gsub! %r{<figure[^>]*\s+id="([^"]+)".*?<figcaption>(?:\s*<p>)?}m do |match|
      if labels.key? $1
        %{#{match}<span class="label">#{h labels[$1]}:</span> }
      else
        match
      end
    end
  end

  # Sets the labels of unlabeled references in the text
  def set_reference_labels content, labels
    content.gsub! %r{(<a href="#([^"]+)">)(</a>)} do |match|
      if labels.key? $2
        "#{$1}#{h labels[$2]}#{$3}"
      else
        match
      end
    end
  end

  # Parses a string of HTML attributes
  def parse_attributes attribute_list
    attribute_list.scan(/\s*(\w+)\s*=\s*"([^"]+)"\s*/)
                  .map { |k,v| [k.downcase.to_sym, v] }
                  .to_h
  end
end

class Transpile
  def self.text(content)
    renderer = Redcarpet::Render::HTML.new(filter_html: true)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true, fenced_code_blocks: true)

    MentionService.transpile_mentions(markdown.render(content))
  end
end

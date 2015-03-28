module ApplicationHelper
  def markdown(text)
    render_options = {
      filter_html: true,
      hard_wrap: true,
      prettify: true
    }

    renderer = Redcarpet::Render::HTML.new(render_options)

    extensions = {
      strikethrough: true,
      fenced_code_blocks: true,
      superscript: true,
      footnotes: true,
      quote: true,
      underline: true
    }

    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end
end

module ApplicationHelper

  def markdown(text)
    #avoid expectation error
    if text != nil

      render_options = {
        filter_html: true,
        hard_wrap: true,
        autolink: true,

      }

      renderer = RougeHTML.new(render_options)

      extensions = {
        no_intra_emphasis: true,
        strikethrough: true,
        fenced_code_blocks: true,
        superscript: true,
        footnotes: true,
        quote: true,
      }

      Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe

    end
  end

end

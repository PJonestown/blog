module CommentsHelper
  def nested_comments(comments)
    comments.map do |comment, sub_comments|
      content_tag(:div, render(comment), :class => "nested_comments")
    end.join.html_safe
  end
end

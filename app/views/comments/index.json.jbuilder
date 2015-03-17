json.array!(@comments) do |comment|
  json.extract! comment, :id, :body, :commentable_id, :commentable_type, :commenter_id
  json.url comment_url(comment, format: :json)
end

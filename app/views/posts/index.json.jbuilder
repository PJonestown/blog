json.array!(@posts) do |post|
  json.extract! post, :id, :title, :body, :admin_id
  json.url post_url(post, format: :json)
end

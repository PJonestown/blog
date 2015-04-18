json.array!(@drafts) do |draft|
  json.extract! draft, :id, :title, :body, :admin_id
  json.url draft_url(draft, format: :json)
end

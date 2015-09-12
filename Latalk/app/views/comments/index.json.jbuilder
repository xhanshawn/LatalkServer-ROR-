json.array!(@comments) do |comment|
  json.extract! comment, :id, :like, :user_id, :message_id
  json.url comment_url(comment, format: :json)
end

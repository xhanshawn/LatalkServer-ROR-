json.array!(@sessions) do |session|
  json.extract! session, :id, :user_name, :logout_by
  json.url session_url(session, format: :json)
end

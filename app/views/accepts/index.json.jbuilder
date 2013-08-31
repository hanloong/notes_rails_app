json.array!(@accepts) do |accept|
  json.extract! accept, :user_id, :terms_and_condition_id
  json.url accept_url(accept, format: :json)
end

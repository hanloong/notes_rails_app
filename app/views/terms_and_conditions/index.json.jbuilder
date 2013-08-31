json.array!(@terms_and_conditions) do |terms_and_condition|
  json.extract! terms_and_condition, :title, :body
  json.url terms_and_condition_url(terms_and_condition, format: :json)
end

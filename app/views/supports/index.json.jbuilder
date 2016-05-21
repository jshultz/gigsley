json.array!(@supports) do |support|
  json.extract! support, :id
  json.url support_url(support, format: :json)
end

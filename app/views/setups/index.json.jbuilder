json.array!(@setups) do |setup|
  json.extract! setup, :id
  json.url setup_url(setup, format: :json)
end

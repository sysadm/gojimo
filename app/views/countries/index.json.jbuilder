json.array!(@countries) do |country|
  json.extract! country, :id, :code, :name, :link
  json.url country_url(country, format: :json)
end

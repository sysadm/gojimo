json.array!(@qualifications) do |qualification|
  json.extract! qualification, :id, :system_id, :last_modified, :name, :link, :country_id
  json.url qualification_url(qualification, format: :json)
end

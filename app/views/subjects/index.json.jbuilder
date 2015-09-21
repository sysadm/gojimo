json.array!(@subjects) do |subject|
  json.extract! subject, :id, :system_id, :name, :link, :icon, :colour
  json.url subject_url(subject, format: :json)
end

json.array!(@experiencelinks) do |experiencelink|
  json.extract! experiencelink, :id
  json.url experiencelink_url(experiencelink, format: :json)
end

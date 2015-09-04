json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :venue, :genere, :event_date_time
  json.url event_url(event, format: :json)
end

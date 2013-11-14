json.array!(@series) do |series|
  json.extract! series, :name, :value, :currency
  json.url series_url(series, format: :json)
end

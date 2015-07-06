json.array!(@poems) do |poem|
  json.extract! poem, :id, :title, :slug, :image
  json.url poem_url(poem, format: :json)
end

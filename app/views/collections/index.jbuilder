json.files do
  json.array! @collections do |collection|
    json.url collection.file.url
    if collection.file.image?(collection.file)
      json.thumbnailUrl collection.file.thumbnail.url
    else
      json.thumbnailUrl 'http://alternatip.com/img/count.png'
    end
    json.name collection.file_identifier
    json.type collection.file.content_type
    json.size collection.file.size
    json.deleteUrl collection_path(collection)
    json.deleteType "DELETE"
    json.title collection.title
  end
end

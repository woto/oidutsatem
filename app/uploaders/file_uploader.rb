class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  #include CarrierWave::MimeTypes

  #process :set_content_type

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumbnail, if: :image? do
    process :resize_to_fit => [200, 200]
  end

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

end

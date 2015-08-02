# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.id}"
  end

  def tmp_dir
    "tmp/uploads/cache/#{model.id}"
  end

  version :thumb, if: :image? do
    process :resize_to_fit => [50, 50]
  end

  protected

  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end
end

class PostUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/default_user_avatar.png")
  end

  def extension_allowlist
    %w(jpg jpeg gif png)
  end

end

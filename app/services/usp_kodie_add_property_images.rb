class UspKodieAddPropertyImages
  def initialize(user, images_type, images_name, images_path)
    @user = user
    @images_type = images_type
    @images_name = images_name
    @images_path = images_path
  end

  def save_property_images
    Rails.logger.error("Processing images for user #{@user}")
    Rails.logger.error("Processing images for user #{@images_type}")
    Rails.logger.error("Processing images for user #{@images_name}")
    Rails.logger.error("Processing images for user #{@images_path}")
    ActiveRecord::Base.connection_pool.with_connection do |connection|
      result = connection.query("CALL USP_KODIE_SAVE_PROPERTY_IMAGES('#{@user}', '#{@images_type}', '#{@images_name}', '#{@images_path}')")
      Rails.logger.error("step4")
      Rails.logger.error(result)
      result
    end
     
  end
end

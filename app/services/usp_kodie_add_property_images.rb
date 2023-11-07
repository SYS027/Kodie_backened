# class UspKodieAddPropertyImages
    # def initialize(user, images_type, images_name, images_path)
    #   @user = user
    #   @images_type = images_type
    #   @images_name = images_name
    #   @images_path = images_path
    # end
  
#     def save_property_images
#       Rails.logger.error("3")
#       Rails.logger.error(@user)
  
#       connection = ActiveRecord::Base.connection.raw_connection
#       # Assuming 'insert_data' is a column in your stored procedure
#       result = connection.query("CALL USP_KODIE_SAVE_PROPERTY_IMAGES('#{@user}','#{@images_type}','#{@images_name}','#{@images_path}')")
#       connection.close
  
#       Rails.logger.error("4")
#       Rails.logger.error(result)
  
#       result
#     end
#   end

# app/services/usp_kodie_add_property_images.rb
class UspKodieAddPropertyImages
    def initialize(user, images)
      @user = user
      @images = images
    end
  
    def save_property_images
      Rails.logger.error("Processing images for user #{@user}")
  
      connection = ActiveRecord::Base.connection.raw_connection
  
      if @images.is_a?(Array)
        images_result = []
  
        @images.each_with_index do |image, index|
          Rails.logger.error("Processing image #{index + 1}")
  
          images_type = image[:images_type]
          images_name = image[:images_name]
          images_path = image[:images_path]
  
         
          Rails.logger.error("Type: #{images_type}")
          Rails.logger.error("Name: #{images_name}")
          Rails.logger.error("Path: #{images_path}")
  
         
          result = connection.query("CALL USP_KODIE_SAVE_PROPERTY_IMAGES('#{@user}','#{images_type}','#{images_name}','#{images_path}')")
          Rails.logger.error("Result for image #{index + 1}: #{result}")
  
          images_result << result
        end
  
        connection.close
        images_result
      else
        Rails.logger.error("Invalid format for images. Expected an array.")
        connection.close
        []
      end
    end
  end
  

  
  
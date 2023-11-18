class UspKodieGetAllPropertyDetailsReview
  def initialize(user)
    @user = user
  end

  def get_all_details(request)
    Rails.logger.error("step3")
    Rails.logger.error(@user)
    connection = ActiveRecord::Base.connection.raw_connection
    result = connection.query("CALL USP_KODIE_GET_PROPERTY_DETAILS_Test('#{@user}')")
    
    connection.close
    Rails.logger.error("step4")
    Rails.logger.error(result.to_a)
   
    results = result.to_a

    # Pass request as a parameter to process_data
    processed_data = process_data(results, request)
    
    # Return processed_data
    processed_data
  end 

  private

  def process_data(results, request)
    processed_data = results.map do |row|
      {
        location: row[0],
        property_description: row[1],
        property_type_id: row[2],
        property_type: row[3],
        key_features_id: row[4],
        key_features: row[5],
        additional_features: row[6],
        additional_key_features: row[7],
        image_path: generate_image_paths(row[8], request, "prefix_"),
        video_path: generate_image_paths(row[9], request, "prefix_")
      }
    end
    processed_data
  end
  def generate_image_paths(image_names, request, prefix_text)
   
    return [] if image_names.nil?
    
    Rails.logger.error(image_names)
     image_names_array = image_names.split(',').map(&:strip)
     Rails.logger.error(image_names_array)
    base_url = "#{request.protocol}#{request.host_with_port}/images/"
    image_paths_array = image_names_array.map { |image_name| "#{base_url}#{image_name}" }
    Rails.logger.error(image_paths_array)
    image_paths_array
  end
 
end


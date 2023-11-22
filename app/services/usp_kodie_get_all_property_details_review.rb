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
        location_longitude: row[1],
        location_latitude: row[2],
        State:row[3],
        Country:row[4],
        City:row[5],
        property_description: row[6],
        property_type_id: row[7],
        property_type: row[8],
        key_features: row[9],
        floor_size: row[10],
        land_area: row[11],
        additional_features: row[12],
        additional_key_features: row[13],
        image_path: generate_image_paths(row[14], request, "prefix_"),
        video_path: generate_image_paths(row[15], request, "prefix_")
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


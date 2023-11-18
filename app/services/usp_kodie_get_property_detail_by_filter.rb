class UspKodieGetPropertyDetailByFilter

    def initialize(property_filter,user_account_id)
        @property_filter = property_filter
        @user_account_id = user_account_id
    end
    
    def get_property_details_filter(request)
        Rails.logger.error("step1prop")
        Rails.logger.error(@property_filter)
        Rails.logger.error(@user_account_id)
        connection = ActiveRecord::Base.connection.raw_connection
        result = connection.query("CALL USP_KODIE_GET_ALL_PROPERTY_BY_FILTER('#{@property_filter}','#{@user_account_id}')")
    
        connection.close
        Rails.logger.error("step2prop")
        Rails.logger.error(result.to_a)
        results = []
        result.each do |row|
          results << row
        end
    
        # Pass request as a parameter to process_data
        processed_data = process_data(results, request)
    
        # Return processed_data
        processed_data
    end
    
      private
    
     def process_data(results, request)
        processed_data = results.map do |row|
          {
            property_id: row[0],
            image_path: generate_image_paths(row[1], request, "prefix_"),
            location: row[4],
            property_type: row[2],
            property_type_id: row[3]
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
   
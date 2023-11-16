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
            image_path: row[1].nil? ? nil : "#{request.protocol}#{request.host_with_port}/images/#{row[1]}",
            location: row[3],
            property_type: row[2],
          }
        end
        processed_data
    end

end 
   
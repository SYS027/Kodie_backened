class UspKodieGetAllPropertyDetailsReview

   def initialize(user)
    @user =user
   end 

   def get_all_details
    Rails.logger.error("step3")
    Rails.logger.error(@user)
    connection = ActiveRecord::Base.connection.raw_connection
    result = connection.query("CALL USP_KODIE_GET_PROPERTY_DETAILS('#{@user}')")
    result1 = connection.query("CALL USP_KODIE_GETALL_IMAGE_PATH_USING_ID('#{@user}')")
    connection.close
    Rails.logger.error("step4")
    Rails.logger.error(result.to_a)
    Rails.logger.error(result1.to_a)
    results = []
    result.each do |row|
      results << row
    end
    process_data(results)
   end 
    
 
   private
  
    def process_data(results)
      processed_data = results.map do |row|
        {
          image_path: row[0],
          location: row[1],
          property_description: row[2],
          property_type: row[3],
          key_features: row[4],
          additional_features: row[5]
        }
      end
      processed_data
    end
end
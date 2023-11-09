class UspKodieGetAllPropertyDetailsReview

   def initialize(user)
    @user =user
   end 

   def get_all_details
    Rails.logger.error("step3")
    Rails.logger.error(@user)
    connection = ActiveRecord::Base.connection.raw_connection
    result = connection.query("CALL USP_KODIE_GET_PROPERTY_DETAILS('#{@user}')")
    
    connection.close
    Rails.logger.error("step4")
    Rails.logger.error(result.to_a)
   
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
         
          location: row[0],
          property_description: row[1],
          property_type: row[2],
          key_features: row[3],
          additional_features: row[4],
          additional_key_features: row[5],
          image_path: row[6]
        }
      end
      processed_data
    end
end
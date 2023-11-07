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
    Rails.logger.error(result)
    Rails.logger.error(result.to_a) 
    value = result.to_a
    Rails.logger.error("step5")
    Rails.logger.error(value[0])
    get=value[0]
    Rails.logger.error("step6")
    Rails.logger.error(get[0])
    Rails.logger.error("step8")
    
    Rails.logger.error(value)

    value
   end 

end
class UspKodieSaveAddPropertyDetails


  def initialize( add_property_details)
    @add_property_details = add_property_details
   
  
  end

  def create_post_with_tags
    Rails.logger.error("3")
    Rails.logger.error(@add_property_details)
  
    connection = ActiveRecord::Base.connection.raw_connection
    add_property_details = connection.escape(@add_property_details.to_json)
    
    Rails.logger.error(add_property_details)
   
    # Assuming 'insert_data' is a column in your stored procedure
    result = connection.query("CALL USP_KODIE_SAVE_ADD_PROPERTY_DETAILS('#{add_property_details}')")
    connection.close

    result
    Rails.logger.error("4")
    Rails.logger.error(result)
  end

end    
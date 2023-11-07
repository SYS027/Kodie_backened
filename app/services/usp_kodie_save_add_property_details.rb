class UspKodieSaveAddPropertyDetails
  def initialize(add_property_details)
    @add_property_details = add_property_details
  end

  def create_post_with_tags
    Rails.logger.error("3")
    Rails.logger.error(@add_property_details)
   
    connection = ActiveRecord::Base.connection.raw_connection
    @out_property_id = 000000;
    sql = "CALL USP_KODIE_SAVE_ADD_PROPERTY_DETAILS(?, @out_property_id);"
    Rails.logger.error("4")
    statement = connection.prepare(sql)
    statement.execute(@add_property_details.to_json)
    Rails.logger.error("5")
    query_select = "SELECT @out_property_id AS out_property_id;"
    output_params = connection.query(query_select).first
    Rails.logger.error("6")
    Rails.logger.error(output_params)
    Rails.logger.error(output_params.to_a)
    value = output_params.to_a.flatten.first
    Rails.logger.error(value)
  
    statement.close
    value
  end
end

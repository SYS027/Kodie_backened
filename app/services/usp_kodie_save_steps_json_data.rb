class UspKodieSaveStepsJsonData
  def initialize( account_details,property_details)
    @account_details = account_details
    @property_details = property_details
  
  end

  def create_post_with_tags
    Rails.logger.error("3")
    Rails.logger.error(@account_details)
    Rails.logger.error(@property_details)
    connection = ActiveRecord::Base.connection.raw_connection
    account_details_json = connection.escape(@account_details.to_json)
    property_details_json = connection.escape(@property_details.to_json)
    Rails.logger.error(account_details_json)
    Rails.logger.error(property_details_json)
    # Assuming 'insert_data' is a column in your stored procedure
    result = connection.query("CALL USP_KODIE_SAVE_ACCOUNT_DETAILS('#{account_details_json}','#{property_details_json}')")
    connection.close

    result
    Rails.logger.error("4")
  end
end

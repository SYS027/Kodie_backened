
class UspKodieSaveStepsJsonData
  
  def initialize(account_details, property_details, user, email, token, device_id, device_type)
    @account_details = account_details
    @property_details = property_details
    @user = user
    @email = email
    @token = token
    @device_id = device_id
    @device_type = device_type
  end
 
  def create_post_with_tags
    begin
      Rails.logger.error("3")
      Rails.logger.error(@account_details)
      Rails.logger.error(@property_details)
 
      Rails.logger.error(@email)
      Rails.logger.error(@user)
      Rails.logger.error(@token)
      Rails.logger.error(@device_id)
      Rails.logger.error(@device_type)
 
 
 
      connection = ActiveRecord::Base.connection.raw_connection
 
      account_details_json = connection.escape(@account_details.to_json)
      property_details_json = connection.escape(@property_details.to_json)
      Rails.logger.error(account_details_json)
      Rails.logger.error(property_details_json)
 
      # First query
      result = connection.query("CALL USP_KODIE_SAVE_ACCOUNT_DETAILS('#{account_details_json}','#{property_details_json}')")
 
      Rails.logger.error("3")
      Rails.logger.error("user")
      Rails.logger.error(@user)
      Rails.logger.error("email")
      Rails.logger.error(@email)
      Rails.logger.error("token")
      Rails.logger.error(@token)
      Rails.logger.error("did")
      Rails.logger.error(@device_id)
      Rails.logger.error("dtype")
      Rails.logger.error(@device_type)
 
      # Check if there are more results
      while connection.more_results?
        # Move to the next result
        connection.next_result
      end
 
      # Second query
      result2 = connection.query("
        CALL USP_KODIE_SAVE_LOGIN_DETAILS(
          '#{@user}',
          '#{@email}',
          '#{@token}',
          '#{@device_id}',
          '#{@device_type}'
        )
      ")
        Rails.logger.error(result2.to_a)
      Rails.logger.error("Database connection closed")
 
    rescue => e
      Rails.logger.error("Error in create_post_with_tags: #{e.message}")
      raise e # Re-raise the exception after logging
    ensure
      connection.close if connection
    end
 
    [result, result2]
    Rails.logger.error("4")
    Rails.logger.error(result.to_a)
    # Rails.logger.error(result2.to_a)
    # result2
    value={user: @user, email: @email,token:  @token,device_id: @device_id,device_type: @device_type}
    value
   
  end
end

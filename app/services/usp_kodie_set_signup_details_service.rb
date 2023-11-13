class UspKodieSetSignupDetailsService
    def initialize(result, email, token, device_id, device_type)
      @result = result
      @email = email
      @token = token
      @device_id = device_id
      @device_type = device_type
    end
  
    def sp_signup_details
      begin
        Rails.logger.error("Attempting to establish a database connection...")
        connection = ActiveRecord::Base.connection.raw_connection
        Rails.logger.error("Database connection established successfully.")

        
        result = connection.query("
            CALL USP_KODIE_SAVE_LOGIN_DETAILS(
               '#{@result}',
               '#{@email}',
               '#{@token}',
               '#{@device_id}',
               '#{@device_type}'
              )
         ")
        
        Rails.logger.error("4")
        Rails.logger.error(result)
  
        # Assuming you need to fetch some data from the result, you can iterate over it:
        # result.each do |row|
        #   # Process each row of the result set
        # end
  
        # Close the connection explicitly (do not close if you need to keep the connection open)
        connection.close
        Rails.logger.error("Database connection closed")
      rescue => e
        Rails.logger.error("Error in sp_signup_details: #{e.message}")
        raise e # Re-raise the exception after logging
      end
  
      result
    end
end

class ForgotPassword
  def initialize(email)
    @email = email
  end

  def sp_reset_1(email)
    begin
      connection = ActiveRecord::Base.connection.raw_connection
      @out_otp = "0"
      sql = "CALL RESET_PASSWORD_(?, @out_otp);"


      Rails.logger.error('step1')

      statement = connection.prepare(sql)
      Rails.logger.error('step2')
      statement.execute(email)
      Rails.logger.error('step3')
      statement.close
      Rails.logger.error('step4')
      query_select = "SELECT @out_otp AS otp;"
      
      connection.next_result if connection.respond_to?(:next_result)


      output_params = connection.query(query_select).first
      Rails.logger.error('step5')
      otp = output_params[0]
      Rails.logger.error('step6')
      output_data = [otp]
      Rails.logger.error('step7')
      
    rescue ActiveRecord::StatementInvalid => e
      # Handle database statement execution error here
      puts "Database statement error: #{e.message}"
      Rails.logger.error("Database statement error: #{e.message}")
    rescue StandardError => e
      # Handle other exceptions here
      puts "An error occurred: #{e.message}"
      Rails.logger.error("An error occurred: #{e.message}")
      # connection = ActiveRecord::Base.connection.raw_connection

      # sql = "CALL USP_KODIE_INSERT_ERROR_LOG('forgot_password', #{e.message});"

      # statement = connection.prepare(sql)
      # statement.execute()
      # statement.close
      # connection.close if connection
      # connection = ActiveRecord::Base.connection.raw_connection   # Call the stored procedure and pass the error message 
      #  sql = "CALL USP_KODIE_INSERT_ERROR_LOG('forgot_password', ?);" 
      #   statement = connection.prepare(sql)  
      #   statement.execute(e.message) 
      #   statement.close
    ensure
      # Ensure the database connection is closed
      connection.close if connection
    end
  end
end

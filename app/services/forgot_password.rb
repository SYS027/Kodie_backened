class ForgotPassword
  def initialize(email)
    @email = email
  end

  def sp_reset_1(email)
    begin
      connection = ActiveRecord::Base.connection.raw_connection
      @out_otp = "000000"
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
      Rails.logger.error(otp)
      output_data =otp.to_s
      Rails.logger.error('step7')
      Rails.logger.error(output_data)
    rescue ActiveRecord::StatementInvalid => e
      # Handle database statement execution error here
      puts "Database statement error: #{e.message}"
      Rails.logger.error("Database statement error: #{e.message}")
    rescue StandardError => e
      # Handle other exceptions here
      puts "An error occurred: #{e.message}"
      Rails.logger.error("An error occurred: #{e.message}")
      # NotificationMailer.alert_admin.deliver
    ensure
      output_data
      connection.close if connection
    end
  end
end










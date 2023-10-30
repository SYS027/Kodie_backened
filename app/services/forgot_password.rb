
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
      
      Rails.logger.error('step4')
      query_select = "SELECT @out_otp AS otp;"
      
      connection.next_result if connection.respond_to?(:next_result)

      statement.close
      output_params = connection.query(query_select).first
      Rails.logger.error('step5')
      otp = output_params[0]
      Rails.logger.error(otp)
      
      NotificationMailer.with(email: email).alert_admin(otp).deliver
      Rails.logger.error('step6')
      Rails.logger.error(otp.length())
      output_data =otp.to_s
      Rails.logger.error('step7')
      Rails.logger.error(output_data)
      output_data
     
    rescue ActiveRecord::StatementInvalid => e
      # Handle database statement execution error here
      puts "Database statement error: #{e.message}"
      Rails.logger.error("Database statement error: #{output_data}")
    rescue StandardError => e
      # Handle other exceptions here
      puts "An error occurred: #{e.message}"
      Rails.logger.error("An error occurred: #{output_data}")
      # NotificationMailer.alert_admin.deliver
    ensure
      output_data
      connection.close if connection
    end
  end
end

# class ForgotPassword
#   def initialize(email)
#     @email = email
#   end

#   def sp_reset_1(email)
#     begin
#       connection = ActiveRecord::Base.connection.raw_connection
#       @out_otp = "000000"
#       sql = "CALL RESET_PASSWORD_(?, ?);"

#       Rails.logger.error('step1')

#       statement = connection.prepare(sql)
#       Rails.logger.error('step2')
#       statement.execute(@email)
#       Rails.logger.error('step3')
      
#       Rails.logger.error('step4')
#       query_select = "SELECT @out_otp AS otp;"
      
#       connection.next_result if connection.respond_to?(:next_result)

#       statement.close
#       output_params = connection.query(query_select).first
#       Rails.logger.error('step5')
#       otp = output_params['otp'].to_s
#       Rails.logger.error(otp)
      
#       NotificationMailer.with(email: @email).alert_admin(otp).deliver
#       Rails.logger.error('step6')
#       Rails.logger.error(otp.length())
#       output_data = otp
#       Rails.logger.error('step7')
#       Rails.logger.error(output_data)
#       output_data
     
#     rescue ActiveRecord::StatementInvalid => e
#       # Handle database statement execution error here
#       puts "Database statement error: #{e.message}"
#       Rails.logger.error("Database statement error: #{e.message}")
#       output_data = nil
#     rescue StandardError => e
#       # Handle other exceptions here
#       puts "An error occurred: #{e.message}"
#       Rails.logger.error("An error occurred: #{e.message}")
#       output_data = nil
#       # NotificationMailer.alert_admin.deliver
#     ensure
#       connection.close if connection
#       output_data
#     end
#   end
# end









# class ForgotPassword

#   def initialize(email)
#     @email = email 
#   end

#   def sp_reset_1(email)
#     begin
#       connection = ActiveRecord::Base.connection.raw_connection
#       @out_otp = 0
#       sql = "CALL RESET_PASSWORD_(?, @out_otp);"
#       Rails.logger.error('1')
#       statement = connection.prepare(sql)
#       statement.execute(email)
#       statement.close
#       Rails.logger.error('2')
#       query_select = "SELECT @out_otp AS otp;"
#       output_params = connection.query(query_select).first
#       Rails.logger.error('3')
#       otp = output_params[0]
#       Rails.logger.error('4')
#       Rails.logger.error(otp)
#       NotificationMailer.with(email: email).alert_admin(otp).deliver
#       Rails.logger.error('5')
#       output_data = [otp]
#     rescue StandardError => e
     
#       Rails.logger.error("Error in ForgotPassword#sp_reset_1: #{e.message}")
#       output_data = nil
#       Rails.logger.error({e.message})
#     ensure
#       connection.close if connection
#     end

#     output_data
#   end
# end
# class ForgotPassword
#   def initialize(email)
#     @email = email
#   end

#   def sp_reset_1(email)
#     begin
#       connection = ActiveRecord::Base.connection.raw_connection
#       @out_otp = "000000"
#       sql = "CALL RESET_PASSWORD_(?, @out_otp);"


#       Rails.logger.error('step1')

#       statement = connection.prepare(sql)
#       Rails.logger.error('step2')
#       statement.execute(email)
#       Rails.logger.error('step3')
      
#       Rails.logger.error('step4')
#       query_select = "SELECT @out_otp AS otp;"
      
#       connection.next_result if connection.respond_to?(:next_result)

#       statement.close
#       output_params = connection.query(query_select).first
#       Rails.logger.error('step5')
#       otp = output_params[0]
#       Rails.logger.error(otp)
      
#       NotificationMailer.with(email: email).alert_admin(otp).deliver
#       Rails.logger.error('step6')
#       Rails.logger.error(otp.length())
#       output_data =otp.to_s
#       Rails.logger.error('step7')
#       Rails.logger.error(output_data)
     
#     rescue ActiveRecord::StatementInvalid => e
#       # Handle database statement execution error here
#       puts "Database statement error: #{e.message}"
#       Rails.logger.error("Database statement error: #{e.message}")
#     rescue StandardError => e
#       # Handle other exceptions here
#       puts "An error occurred: #{e.message}"
#       Rails.logger.error("An error occurred: #{e.message}")
#       # NotificationMailer.alert_admin.deliver
#     ensure
#       output_data
#       connection.close if connection
#     end
#   end
# end

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
      otp = output_params[0].to_s
      Rails.logger.error(otp)
      
      combined_otp = combine_digits(otp)
      send_combined_otp(combined_otp, email)
      Rails.logger.error('step6')
     
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
      connection.close if connection
    end
  end

  private

  def combine_digits(otp)
    combined_otp = ""
    otp.each_char { |digit| combined_otp += digit }
    combined_otp
  end

  def send_combined_otp(combined_otp, email)
    NotificationMailer.with(email: email).alert_admin(combined_otp).deliver
  end
end






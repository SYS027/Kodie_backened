# class ForgotPassword

#   def initialize(email)
#     @email = email 
#   end

#   def sp_reset_1(email)
#     begin
#       connection = ActiveRecord::Base.connection.raw_connection
#       @out_otp = 0
#       sql = "CALL RESET_PASSWORD_(?, @out_otp);"
#       Rails.logger.error(1)
#       statement = connection.prepare(sql)
#       statement.execute(email)
#       statement.close
#       Rails.logger.error(2)
#       query_select = "SELECT @out_otp AS otp;"
#       output_params = connection.query(query_select).first
#       Rails.logger.error(3)
#       otp = output_params[0]
#       Rails.logger.error(4)
#       Rails.logger.error(otp)
#       NotificationMailer.with(email: email).alert_admin(otp).deliver
#       Rails.logger.error(5)
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

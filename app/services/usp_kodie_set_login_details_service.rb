class UspKodieSetLoginDetailsService
   
    def initialize(result, email,token,device_id,device_type)
        @result= result
        @email = email
        @token = token
        @device_id = device_id
        @device_type = device_type
      end

      def sp_login_details
        
        Rails.logger.error(@result)
        Rails.logger.error(@email)
        Rails.logger.error(@token)
        
        result = ActiveRecord::Base.connection.execute("
           CALL USP_KODIE_SAVE_LOGIN_DETAILS(
              '#{@result}',
              '#{@email}',
              '#{@token}',
              '#{@device_id}',
              '#{@device_type}'
             )
        ")
        Rails.logger.error("Database connected: #{ActiveRecord::Base.connected?}")

        Rails.logger.error("result1")
        Rails.logger.error(result.to_a)
      
        value1 = result.to_a.flatten.first
        Rails.logger.error(value1)
        value1
      end
   
end

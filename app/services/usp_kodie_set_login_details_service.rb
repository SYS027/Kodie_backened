class UspKodieSetLoginDetailsService
   
    def initialize(result, email,token,device_id,device_type)
        @result= result
        @email = email
        @token = token
        @device_id = device_id
        @device_type = device_type
      end

      def sp_login_details
        result = ActiveRecord::Base.connection.execute("
           CALL USP_KODIE_SAVE_LOGIN_DETAILS(
              '#{@result}',
              '#{@email}',
              '#{@token}',
              '#{@device_id}',
              '#{@device_type}'
             )
        ")
        Rails.logger.error("result1")
        Rails.logger.error(result)
        result
      end
   
end

class UspKodieSetLoginDetailsService
   
    def initialize( email,token,device_id,device_type)
        
        @email = email
        @token = token
        @device_id = device_id
        @device_type = device_type
      end

      def sp_login_details
        result = ActiveRecord::Base.connection.execute("
           CALL USP_KODIE_SAVE_LOGIN_DETAILS(
              
              '#{@email}',
              '#{@token}',
              '#{@device_id}',
              '#{@device_type}'
             )
        ")
      end
   
end

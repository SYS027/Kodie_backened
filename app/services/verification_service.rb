class VerificationService
   
    def initialize(user_id, email,token)
        @user_id = user_id
        @email = email
        @token = token
      
      end

      def sp_login_details
        result = ActiveRecord::Base.connection.execute("
           CALL USP_KODIE_MANAGE_EMAIL_VERIFICATION_CODE(
              '#{@user_id}',
              '#{@email}',
              '#{@token}' 
             )
        ")
      end
   
end

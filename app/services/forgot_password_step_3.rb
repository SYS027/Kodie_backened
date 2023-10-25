class ForgotPasswordStep3


    def initialize(email, password)
        @email = email
        @password = password
      end
      
      def sp_reset_password(email,password)
        result = ActiveRecord::Base.connection.execute("
          CALL USP_KODIE_MANAGE_RESET_PASSWORD(
            '#{@email}',
            '#{@password}'
          )
        ")
      end



end    
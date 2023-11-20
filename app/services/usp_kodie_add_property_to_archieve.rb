class UspKodieAddPropertyToArchieve
  
    def initialize(user)
        @user = user
      
    end
    
    def add_property_archieve()
        Rails.logger.error("step1prop")
        Rails.logger.error(@user)
        connection = ActiveRecord::Base.connection.raw_connection
        result = connection.query("CALL USP_KODIE_ADD_PROPERTY_ARCHIEVE('#{@user}')")
    
        connection.close
        Rails.logger.error("step2prop")
        value = result.to_a.flatten.first
        Rails.logger.error(value)
        value
      end 


end    
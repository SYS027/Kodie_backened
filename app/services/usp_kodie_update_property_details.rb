class UspKodieUpdatePropertyDetails

    def initialize(add_property_details)
        @add_property_details = add_property_details
      end
    
      def update_property
        Rails.logger.error("3")
        Rails.logger.error(@add_property_details)
       
        connection = ActiveRecord::Base.connection.raw_connection
        
        sql = "CALL USP_KODIE_SAVE_UPDATE_PROPERTY_DETAILS_test(?);"
        Rails.logger.error("4")
        statement = connection.prepare(sql)
        statement.execute(@add_property_details.to_json)
        Rails.logger.error("5")
       
        statement.close
       
      end

end    
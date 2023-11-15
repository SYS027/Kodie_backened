class UspKodieDeletePropertyDetails
  
    def initialize(property_id)
        @property_id = property_id
    end


    def delete_property_by_id
        Rails.logger.error("step1prop")
        Rails.logger.error(@property_id)
        connection = ActiveRecord::Base.connection.raw_connection
        result = connection.query("CALL USP_KODIE_DELETE_PROPERTY('#{@property_id}')")
    
        connection.close
        value = result.to_a.flatten.first
        Rails.logger.error(value)
        value
    end    
end    
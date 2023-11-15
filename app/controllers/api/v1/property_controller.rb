class Api::V1::PropertyController < ApplicationController
    
  
  
  
   def get_property_details_by_id
         Rails.logger.error(" property Step 1")
         user = params[:user]
         Rails.logger.error(user)
     
         result = UspKodieGetPropertyDetailsByUserId.new(user)
         result_data = result.get_property_details(request)
         Rails.logger.error("result_data")
         Rails.logger.error(result_data)
     
   
        render json: { property_details: result_data , status: true }
   
    end




    def delete_property_by_id
      Rails.logger.error(" property Step 1")
      property_id = params[:property_id]
      Rails.logger.error("property_id")
      Rails.logger.error(property_id)
    
      result = UspKodieDeletePropertyDetails.new(property_id)
      result_data = result.delete_property_by_id
      Rails.logger.error("result_data")
      Rails.logger.error(result_data)
    
      if result_data == "ID not Found"
        render json: { message: "Property ID Not Found", status: true }
      else
        render json: { message: "Property Deleted Successfully", status: true }
      end
    end
     
end

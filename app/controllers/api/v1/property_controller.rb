class Api::V1::PropertyController < ApplicationController
    def get_property_details_by_id
        Rails.logger.error(" property Step 1")
        user = params[:user]
        Rails.logger.error(user)
     
         result = UspKodieGetPropertyDetailsByUserId.new(user)
         result_data = result.get_property_details
         Rails.logger.error("result_data")
         Rails.logger.error(result_data)
     
   
        render json: { property_details: result_data , status: true }
   
      end
end

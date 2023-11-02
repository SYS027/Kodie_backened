class Api::V1::Step1Controller < ApplicationController
   

  def property_details
    {
     user: params[:user],
     user_account_details_id: params[:user_account_details_id],
     location: params[:location],
     location_longitude: params[:location_longitude],
     location_latitude: params[:location_latitude],
     islocation: params[:islocation],
     property_description: params[:property_description],
     property_type: params[:property_type],
     key_features: params[:key_features],
     additional_features: params[:additional_features],
     additional_key_features: params[:additional_key_features],
     autolist: params[:autolist]
    }
  end
  
  def index
    step1_service = UspKodieSaveAddPropertyDetails.new(property_details)
    result= step1_service.create_post_with_tags

    Rails.logger.error(result) 
    render json: { message: result, status: true }
  end
end

# class Api::V1::VerificationController < ApplicationController
#   def account_details
#     {
#       user:  params[:user],
#       first_name: params[:first_name],
#       last_name: params[:last_name],
#       phone_number: params[:phone_number],
#       physical_address: params[:physical_address],
#       organisation_name: params[:organisation_name],
#       referral_code: params[:referral_code],
#       profile_photo: params[:profile_photo],
# 			describe_yourself: params[:describe_yourself],
# 			property_manage: params[:property_manage],
# 			kodie_help: params[:kodie_help]
#     }
#   end
#   def property_details
#     {
#      location: params[:location],
#      location_longitude: params[:location_longitude],
#      location_latitude: params[:location_latitude],
#      islocation: params[:islocation],
#      property_description: params[:property_description],
#      property_type: params[:property_type],
#      key_features: params[:key_features],
#      additional_features: params[:additional_features]

#     }
#   end
  
#   def create
#     Rails.logger.error("1")
#     Rails.logger.error("2")
    
#     json_data = JSON.parse(request.raw_post)
#     account_details = json_data["account_details"]
#     property_details = json_data["property_details"]

#     result = UspKodieSaveStepsJsonData.new(account_details,property_details)
#     result_data = result.create_post_with_tags
  
#     Rails.logger.error("result")
#     Rails.logger.error(result_data)
  
#     render json: { message: "Data Successfully Stored", status: true }
#   end
# end




 
class Api::V1::VerificationController < ApplicationController
  require 'open-uri'
require 'fileutils'
  def account_details
        {
          user:  params[:user],
          first_name: params[:first_name],
          last_name: params[:last_name],
          physical_address: params[:physical_address],
          organisation_name: params[:organisation_name],
          referral_code: params[:referral_code],
          profile_photo: params[:profile_photo],
    			describe_yourself: params[:describe_yourself],
    			property_manage: params[:property_manage],
    			kodie_help: params[:kodie_help]
        }
      end
      def property_details
        {
         location: params[:location],
         location_longitude: params[:location_longitude],
         location_latitude: params[:location_latitude],
         islocation: params[:islocation],
         property_description: params[:property_description],
         property_type: params[:property_type],
         key_features: params[:key_features],
         additional_features: params[:additional_features]
    
        }
      end
 
  def create
    Rails.logger.error("1")
    Rails.logger.error("2")
 
    json_data = JSON.parse(request.raw_post)
    account_details = json_data["account_details"]
    property_details = json_data["property_details"]
 
    # Save the profile photo
    profile_photo_url = account_details["profile_photo"]
    if profile_photo_url
      save_profile_photo(profile_photo_url)
    end
 
    result = UspKodieSaveStepsJsonData.new(account_details, property_details)
    result_data = result.create_post_with_tags
 
    Rails.logger.error("result")
    Rails.logger.error(result_data)
 
    render json: { message: "Data Successfully Stored", status: true }
  end
 
  private

  def save_profile_photo(url)
    filename = File.basename(url)
    local_path = Rails.root.join('public', 'images', filename)
    Rails.logger.error(local_path)
    # open(local_path, 'wb') do |file|
    #   file << open(url).read
    # end
  end
end
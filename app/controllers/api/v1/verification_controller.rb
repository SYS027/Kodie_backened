class Api::V1::VerificationController < ApplicationController
  require 'open-uri'
  require 'fileutils'
   
  def profile_photo
    @profile_photo = params[:profile_photo]
    content_type =  @profile_photo.content_type
    @original_filename =  @profile_photo.original_filename
    @temp_file_path =  @profile_photo.tempfile.path
    Rails.logger.error("temp_file_path")
    Rails.logger.error(@temp_file_path)
    Rails.logger.error("temp_file_path2")
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @physical_address = params[:physical_address]
    @organisation_name = params[:organisation_name]
    @referral_code = params[:referral_code]

    Rails.logger.error(@profile_photo)
    Rails.logger.error(@first_name)
    Rails.logger.error(@last_name)
    Rails.logger.error(@physical_address)
    Rails.logger.error(@organisation_name)
    Rails.logger.error(@referral_code)
  end

  def account_details
    {
      first_name: @first_name,
      last_name: @last_name,
      physical_address: @physical_address,
      organisation_name: @organisation_name,
      referral_code: @referral_code,
      profile_photo: @original_filename
    }
  end

  def property_details
    {
      location: @organisation_name,
      location_longitude: @organisation_name
      # Add other properties as needed
    }
  end

  def create
    profile_photo
    Rails.logger.error("2")
    Rails.logger.error(@first_name)
    Rails.logger.error(@last_name)
    
    Rails.logger.error("2")
    Rails.logger.error("2")

    

    profile_photo_path = params[:profile_photo]
    if profile_photo_path.present?
      save_profile_photo(profile_photo_path.tempfile)
      account_details['profile_photo'] = profile_photo_path.original_filename
    end

    result = UspKodieSaveStepsJsonData.new(account_details, property_details)
    result_data = result.create_post_with_tags

    Rails.logger.error("result")
    Rails.logger.error(result_data)

    render json: { message: "Data Successfully Stored", status: true }
  end

  private

  def save_profile_photo(file)
    filename = File.basename(file.path)
    local_path = Rails.root.join('public', 'images', filename)

    FileUtils.cp(file.path, local_path)
  end

  def account_details_params
    params[:account_details].present? ? JSON.parse(params[:account_details]) : {}
  end

  def property_details_params
    params[:property_details].present? ? JSON.parse(params[:property_details]) : {}
  end
end

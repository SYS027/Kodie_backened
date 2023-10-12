class Api::V1::Step1Controller < ApplicationController
  def index

    user_id = params[:user_id]
    first_name = params[:first_name]
    last_name = params[:last_name]
    phone_no = params[:phone_no]
    physical_address = params[:physical_address]
    organization_name = params[:organization_name]
    referal_code = params[:referal_code]
    
    step1_service = Step1Service.new(
      user_id,
      first_name,
      last_name,
      phone_no,
      physical_address,
      organization_name,
      referal_code
    )
   
    step1_service.sp_step_one

    render json: { message: 'Insert Data ' }
  end
end

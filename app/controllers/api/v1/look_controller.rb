class Api::V1::LookController < ApplicationController
    def index
      p_parent_code = params[:P_PARENT_CODE]
      p_type = params[:P_TYPE]

      look_up_service = LookUpService.new(p_parent_code, p_type)
      result = look_up_service.step_2
  
      render json: { data: result , status: true }
    end
  end


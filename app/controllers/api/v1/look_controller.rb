# class Api::V1::LookController < ApplicationController
#   def index
#     p_parent_code = params[:P_PARENT_CODE]
#     p_type = params[:P_TYPE]

#     step2_service = LookUpService.new(p_parent_code, p_type)
#     result = step2_service.step_2
   
#     render json: { message: result}
    
#   end
# end

# app/controllers/api/v1/look_controller.rb

# class Api::V1::LookController < ApplicationController
#   def index
#     p_parent_code = params[:P_PARENT_CODE]
#     p_type = params[:P_TYPE]

#     step2_service = LookUpService.new(p_parent_code, p_type)
#     result = step2_service.step_2

#     if result
#       render json: { lookup_key: result[:lookup_key], lookup_description: result[:lookup_description] }
#     else
#       render json: { error: 'Failed to fetch lookup data' }, status: :unprocessable_entity
#     end
#   end
# end

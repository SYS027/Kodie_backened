class Step1Service
def initialize(user_id, first_name, last_name, phone_no, physical_address,organization_name,referal_code)
     @user_id = user_id
      @first_name = first_name
     @last_name = last_name
     @phone_no = phone_no
     @physical_address = physical_address
     @organization_name =organization_name
     @referal_code=referal_code
 end

def sp_step_one
  result = ActiveRecord::Base.connection.execute("
     CALL USP_KODIE_INSERT_STEP_ONE(
        '#{@user_id}',
        '#{@first_name}',
        '#{@last_name}',
        '#{@phone_no}',
        '#{@physical_address}',
        '#{@organization_name}',
        '#{@referal_code}'
       )
  ")
end
end    
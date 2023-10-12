class LookUpService
  def initialize(p_parent_code, p_type)
    @p_parent_code = p_parent_code
    @p_type = p_type
  end

  def step_2
    result = ActiveRecord::Base.connection.execute(fetch_lookup_master_sql)
    parse_result(result)
  end

  private

  def fetch_lookup_master_sql
    if @p_type == 'QUESTION'
      "CALL USP_KODIE_FETCH_LOOKUP_MASTER('#{@p_parent_code}', '#{@p_type}', @p_lookup_key, @p_lookup_description);"
    else
      "CALL USP_KODIE_FETCH_LOOKUP_MASTER('#{@p_parent_code}', '#{@p_type}', @p_lookup_key, @p_lookup_description);"
    end
  end

  def parse_result(result)
    if result.present? && result.first.present?
      {
        lookup_key: result.first['P_LOOKUP_KEY'],
        lookup_description: result.first['P_LOOKUP_DESCRIPTION']
      }
    else
      # Handle the case where the result is empty or not as expected.
      nil
    end
  end
end


class LookUpService
    def initialize(parent_code, type)
      @parent_code = parent_code
      @type = type
    end
  
    def step_2
      sql = "CALL USP_KODIE_FETCH_LOOKUP_MASTER('#{@parent_code}', '#{@type}')"
      result = ActiveRecord::Base.connection.raw_connection.query(sql)
      
      results = []
      result.each do |row|
        results << row
      end
      process_data(results)
    end
  
    private
  
    def process_data(results)
      processed_data = results.map do |row|
        {
          lookup_key: row[0],
          description: row[1]
        }
      end
      processed_data
    end
  end
  

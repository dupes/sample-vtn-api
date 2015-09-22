module Api

  module ManageVen

    def self.ven_id(request_body)
      body_hash = ActiveSupport::JSON.decode(request_body.to_s) # Argument should be JSON as a string

      ven = Ven.find_by_name(body_hash['ven'])

      result_hash = { "ven_id" => ven.ven_id }

      return result_hash
    end

    # # # # # # # # # # # # # # # # # # # # # # # #

    def self.status(request_body)
      body_hash = ActiveSupport::JSON.decode(request_body.to_s) # Argument should be JSON as a string

      ven = Ven.find_by_ven_id(body_hash['ven_id'])

      result_hash = { "status" => ven.status }

      return result_hash
    end

    # # # # # # # # # # # # # # # # # # # # # # # #

    def self.last_comm_time(request_body)
      body_hash = ActiveSupport::JSON.decode(request_body.to_s) # Argument should be JSON as a string

      ven = Ven.find_by_ven_id(body_hash['ven_id'])

      result_hash = { "last_comm_time" => ven.last_comm_at }

      return result_hash
    end
  end
end

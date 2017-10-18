module Api

  module ManageVen

    SCHEMA = {
        ven_id: { validate: false },
        status: { validate: false },
        last_comm_time: { validate: false }
    }
    
    #####################################################################

    def self.ven_id(request_body)
      ven = Ven.find_by_name(request_body['ven'])

      result_hash = { "ven_id" => ven.ven_id }

      return result_hash
    end

    #####################################################################

    def self.status(request_body)
      ven = Ven.find_by_ven_id(request_body['ven_id'])

      result_hash = { "status" => ven.status }

      return result_hash
    end

    #####################################################################

    def self.last_comm_time(request_body)
      ven = Ven.find_by_ven_id(request_body['ven_id'])

      result_hash = { "last_comm_time" => ven.last_comm_at }

      return result_hash
    end
  end
end

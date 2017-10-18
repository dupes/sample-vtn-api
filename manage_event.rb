module Api

  class ManageEvent

    SCHEMA = {
        create: { validate: false },
        info: { validate: false }
    }
    
    #####################################################################

    def self.add_default_signal(event, signal_name_id, signal_type_id)
      signal = event.event_signals.new

      signal.signal_name_id = signal_name_id
      signal.signal_type_id = signal_type_id 

      signal.default

      signal.save!
    end
    
    #####################################################################

    def self.add_or_update_signal_interval(event, signal_index, uid, duration, payload)

      signal = event.event_signals[signal_index]

      event_signal_interval = signal.event_signal_intervals.find_by_uid(uid)

      if event_signal_interval.nil?
        event_signal_interval = signal.event_signal_intervals.new
      end

      event_signal_interval.uid = uid
      event_signal_interval.duration = duration
      event_signal_interval.payload = payload
      event_signal_interval.save!
    end
    
    ########################################################
    
    def self.create(request_body)
      event = ::Event.new

      event.dtstart_str = request_body['dtstart_str']
      event.duration = request_body['duration']
      event.market_context_id = ::MarketContext.find_by_name!(request_body['market_context']).id
      event.priority = request_body['priority']
      event.response_required_type_id = ::ResponseRequiredType.find_by_name!(request_body['response_required_type']).id

      add_default_signal(
        event, 
        ::SignalName.find_by_name!(request_body['signal_name']).id, 
        ::SignalType.find_by_name!(request_body['signal_type']).id)
        
      add_or_update_signal_interval(
        event, 
        0, 
        0, 
        request_body['duration'], 
        request_body['payload'])

      # some default values
      event.event_id = SecureRandom.hex(10)
      event.tolerance = 0
      event.ei_notification = 0
      event.ei_rampup = 0
      event.ei_recovery = 0
      
      event.save!

      targets = request_body['targets']

      targets.each do |target|
        if target['type'].downcase == 'group'
          event.targets << ::Target.find_by_name!(target['identifier'])
        elsif target['type'].downcase == 'ven'
          ven_instance = ::Ven.find_by_ven_id(target['identifier'])
          event.targets << ::Target.find_by_name!("VEN:#{ven_instance.id.to_s}")
        end
      end
      
      event.publish

      result_hash = { "event_id" => event.event_id }

      return result_hash
    end
    
    ########################################################
    
    def self.info(request_body)
      event = ::Event.find_by_event_id(request_body['event_id'])

      result_hash = {
        "event" => event.attributes.symbolize_keys.except!(:id, :event_status_id, :market_context_id, :response_required_type_id,
          :payload, :payload, :account_id, :schedule_id)
      }

      result_hash['event'].merge!("market_context" => event.market_context.name)
      result_hash['event'].merge!("event_status" => event.event_status.name)
      result_hash['event'].merge!("response_required_type" => event.response_required_type.name)

      return result_hash
    end
  end
end

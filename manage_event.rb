module Api

  class ManageEvent

    def self.create(request_body)
      body_hash = ActiveSupport::JSON.decode(request_body.to_s) # Argument should be JSON as a string

      event = ::Event.new

      event.dtstart_str = body_hash['dtstart_str']
      event.duration = body_hash['duration']
      event.market_context_id = ::MarketContext.find_by_name(body_hash['market_context']).id
      event.priority = body_hash['priority']
      event.response_required_type_id = ::ResponseRequiredType.find_by_name(body_hash['response_required_type']).id

      signal_name_id = ::SignalName.find_by_name(body_hash['signal_name']).id
      signal_type_id = ::SignalType.find_by_name(body_hash['signal_type']).id
      payload = body_hash['payload']
      
      # Event.default_event sets values for and saves Event, EventSignal, EventSignalInterval instances
      ::Event.default_event(event, signal_name_id, signal_type_id, payload)

      if body_hash['group'].present? # not nil, and not empty
        group_instance = ::Group.find_by_name(body_hash['group'])
        event_group = event.event_groups.new
        event_group.group_id = group_instance.id
        event_group.save!
      end

      event.publish

      result_hash = { "event_id" => event.event_id }

      return result_hash
    end
    
    # # # # # # # # # # # # # # # # # # # # # # # #

    def self.create_schedule(request_body)
      body_hash = ActiveSupport::JSON.decode(request_body.to_s) # Argument should be JSON as a string

      start_date = body_hash['start_date']
      end_date = body_hash['end_date']
      start_time_str = body_hash['start_time_str']
      signal_name_id = ::SignalName.find_by_name(body_hash['signal_name']).id
      signal_type_id = ::SignalType.find_by_name(body_hash['signal_type']).id
      payload = body_hash['payload']
      targets = body_hash['targets']
      event_attrs = body_hash['event']

      schedule = ::Schedule.new

      schedule.start_date = start_date
      schedule.end_date = end_date
      schedule.start_time_str = start_time_str

      event = ::Event.new

      event.dtstart_str = "#{ start_date } #{ start_time_str }"
      event.duration = event_attrs['duration']
      event.market_context_id = ::MarketContext.find_by_name(event_attrs['market_context']).id
      event.priority = event_attrs['priority']
      event.response_required_type_id = ::ResponseRequiredType.find_by_name(event_attrs['response_required_type']).id
      event.template = true # Since we're using this as a template for a Schedule
      
      ::Schedule.default_schedule(schedule, event, signal_name_id, signal_type_id, payload)

      targets.each do |target|
        # Since these two types will have different identifiers (name vs. ven_id),
        # we need to handle the instance lookup differently based on type
        if target['type'].downcase == 'group'
          group_instance = ::Group.find_by_name(target['identifier'])
          event_group = event.event_groups.new
          event_group.group_id = group_instance.id
          event_group.save!
        elsif target['type'].downcase == 'ven'
          ven_instance = ::Ven.find_by_ven_id(target['identifier'])
          event_ven = event.event_vens.new
          event_ven.ven_id = ven_instance.id
          event_ven.save!
        end
      end

      result_hash = { "event_id" => event.event_id }

      return result_hash
    end

    # # # # # # # # # # # # # # # # # # # # # # # #

    def self.info(request_body)
      body_hash = ActiveSupport::JSON.decode(request_body.to_s) # Argument should be JSON as a string

      event = ::Event.find_by_event_id(body_hash['event_id'])

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

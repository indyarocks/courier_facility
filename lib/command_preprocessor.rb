module CourierFacility
  module CommandPreprocessor
    VALID_COMMANDS_WITH_ARGS = {
      create_parking_slot_lot: {
        regex: /^create_parking_slot_lot (?<rack_size>\d+)$/,
        capture: [:rack_size]
      },
      park: {
        regex: /^park (?<code>\d+) (?<weight>\d+)$/,
        capture: [:code, :weight]
      },
      status: {
        regex: /^status$/,
        capture: []
      },
      delivery: {
        regex: /^leave (?<slot_number>\d+) for delivery$/,
        capture: [:slot_number]
      },
      parcel_code_for_parcels_with_weight: {
        regex: /^parcel_code_for_parcels_with_weight (?<weight>\d+)$/,
        capture: [:weight]
      },
      slot_numbers_for_parcels_with_weight: {
        regex: /^slot_numbers_for_parcels_with_weight (?<weight>\d+)$/,
        capture: [:weight]
      },
      slot_number_for_registration_number: {
        regex: /^slot_number_for_registration_number (?<code>\d+$)/,
        capture: [:code]
      }
    }.freeze

    # VALID_COMMANDS_REGEX = /
    # (?<create_parking_slot_lot>create_parcel_slot_lot \d+)|
    # (?<park>park \d+ \d+)|
    # (?<status>status)|
    # (?<delivery>leave \d+ for delivery)|
    # (?<parcel_code_for_parcels_with_weight>parcel_code_for_parcels_with_weight \d+)|
    # (?<slot_numbers_for_parcels_with_weight>slot_numbers_for_parcels_with_weight \d+)|
    # (?<slot_number_for_registration_number>slot_number_for_registration_number \d+)/x
    
    def self.preprocess_text_command(text)
      # sanitize text command
      input_command = format_text(text)
      match_command, args = nil, {}
      VALID_COMMANDS_WITH_ARGS.each do |command, hash|
        match_data = hash[:regex].match(input_command)
        unless match_data.nil?
          match_command = command
          hash[:capture].each {|key| args[key] = match_data[key].to_i}
          break 
        end
      end
      {
        match_command: match_command,
        args: args
      }
    end

    private
      def self.format_text(text)
        text.to_s.strip.gsub(/\s+/, ' ').downcase
      end
  end
end

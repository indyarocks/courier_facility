module CourierFacility
  module CommandPreprocessor
    VALID_COMMANDS_WITH_ARGS = {
      create_parcel_slot_lot: {
        regex: /^create_parcel_slot_lot (?<required_rack_size>\d+)$/,
        capture: [:required_rack_size]
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

    # ASSUMPTION: All the arguments are integer.
    # To add other data type, we'll have to add data_type key along with each capture key in VALID_COMMANDS_WITH_ARGS
    def preprocess_text_command(text)
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
        command: match_command,
        args: args
      }
    end

    private
      def format_text(text)
        text.to_s.strip.gsub(/\s+/, ' ').downcase
      end
  end
end

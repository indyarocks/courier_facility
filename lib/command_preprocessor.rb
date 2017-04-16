module CourierFacility
  module CommandPreprocessor
    VALID_COMMANDS = {
      create_parking_slot_lot: /^create_parcel_slot_lot (\d+)$/,
      park: /^park (\d+) (\d+)$/,
      status: /^status$/,
      delivery: /^leave (\d+) for delivery$/,
      parcel_code_for_parcels_with_weight: /^parcel_code_for_parcels_with_weight (\d+)$/,
      slot_numbers_for_parcels_with_weight: /^slot_numbers_for_parcels_with_weight (\d+)$/,
      slot_number_for_registration_number: /^slot_number_for_registration_number (\d+$)/
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
      match_command = nil
      VALID_COMMANDS.each do |command, regex|
        match_data = regex.match(input_command)
        match_command = $&
        break unless match_data.nil?
      end
      match_command
    end

    private
      def self.format_text(text)
        text.to_s.strip.gsub(/\s+/, ' ').downcase
      end
  end
end

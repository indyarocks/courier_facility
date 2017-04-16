require_relative 'command_preprocessor'

module CourierFacility
  class CourierFacility
    include ::CourierFacility::CommandPreprocessor

    def process_command(command_text)
      execution_command = preprocess_text_command(command_text)
      return 'invalid_command' if execution_command.nil?
    end

    def park(code, weight)
      # Check if slot available
      # return error if full
      parcel = Parcel.new(args) 
      parcel.allocate_nearest_parcel_slot
    end 

    def status
      # Check the status of all the parcelSlot
    end
    
    def deliver_parcel
      # unallocate the slot
    end

    def parcel_code_for_parcels_with_weight(weight)
    end

    def slot_numbers_for_parcesl_with_weight(weight)
    end

    def slot_number_for_registration_number(code)
    end
  end
end
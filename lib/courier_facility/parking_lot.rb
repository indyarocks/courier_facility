# Making ParkingLot singleton class. As we want only one instance of Parking Lot
require 'singleton'

module CourierFacility
	class ParkingLot
    include Singleton
    attr_accessor :rack_size

    def initialize(size = 0)
      @rack_size = size
    end

		# Has even parcel slot
		def create_parcel_slot_lot(required_rack_size:)
		  if self.rack_size	> 0
        raise ::CourierFacility::Error.new(self), 'Parcel slot already exists!'
      elsif !is_valid_rack_size?(required_rack_size)
        raise ::CourierFacility::Error.new(self), 'Parcel slot count must be an even positive integral number!'
      else
        self.rack_size = required_rack_size
        ::CourierFacility::ParkingSlot.create(required_rack_size)
        return "Created a parcel slot with #{required_rack_size} slots"
      end
		end

    def park(code:, weight:)
      # Check if slot available
      # return error if full
      if ::CourierFacility::ParkingSlot.available_parking_slots.empty?
        raise ::CourierFacility::Error.new(self), 'Sorry, parcel slot is full'
      end
      parcel = create_parcel(code: code, weight: weight)
      ::CourierFacility::ParkingSlot.allocate_nearest_parking_slot(parcel.code)
    end 

    def status(options)
      ::CourierFacility::ParkingSlot.status
    end
    
    def delivery(slot_number:)
      ::CourierFacility::ParkingSlot.deliver(slot_number)
    end

    def parcel_code_for_parcels_with_weight(weight:)
      parcel_codes = ::CourierFacility::Parcel.parcel_codes_with_weight(weight)
      format_search_result(parcel_codes)
    end

    def slot_numbers_for_parcels_with_weight(weight:)
      slot_ids = ::CourierFacility::ParkingSlot.slots_with_parcel_weight(weight)
      format_search_result(slot_ids)
    end

    def slot_number_for_registration_number(code:)
      parcel_codes = ::CourierFacility::ParkingSlot.slots_with_parcel_id(code)
      format_search_result(parcel_codes)
    end

    private
      def create_parking_slots(rack_count)
        ::CourierFacility::ParkingSlot.create(rack_count)
      end

      def is_valid_rack_size?(input_rack_size)
        input_rack_size.is_a?(Integer) && input_rack_size.even? && input_rack_size > 0
      end

      def create_parcel(code:, weight:)
        ::CourierFacility::Parcel.create(code: code, weight: weight) 
      end

      def format_search_result(results)
        if results.empty?
          'NOT FOUND'
        else
          results.join(', ')
        end
      end

	end
end

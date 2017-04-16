module CourierFacility
	class ParkingSlot
		# Has slot
		attr_accessor :id, :parcel_id

    @@parking_slots = {}

    def initialize(args)
      @id = args[:id]
      @parcel_id = args[:parcel_id]
    end

    def self.create(size)
      1.upto(size).each do |id|
        slot = new(id: id)
        all_by_id[id] = slot
      end
      all_by_id.size
    end

    def self.allocate_nearest_parking_slot(parcel_id)
      available_slot_id = nearest_available_parking_slot_id
      if available_slot_id.nil?
        raise ::CourierFacility::Error.new(self), 'Sorry, parcel slot is full'
      else
        all_by_id[available_slot_id].parcel_id = parcel_id
        return "Allocated slot number: #{available_slot_id}"
      end
    end

    def self.available_parking_slots
      @@parking_slots.select { |id, obj| obj.parcel_id.nil? }
    end

    def self.deliver(id)
      slot = all_by_id[id]
      if slot.nil?
        raise ::CourierFacility::Error.new(self), "Invalid slot number #{id}!"
      end
      if slot.parcel_id.nil?
        raise ::CourierFacility::Error.new(self), "Slot number #{id} is already free!"
      else
        slot.parcel_id = nil
        return "Slot number #{id} is free"
      end
    end

    def self.status
      status_message = "Slot No\t\tRegistration No\t\tWeight\n"
      parcels_by_id = get_parcels_by_id
      all_by_id.each do |id, slot|
        if slot.parcel_id.nil?
          status_message.concat("#{id}\t\tNA\t\t\tNA\n")
        else
          parcel = parcels_by_id[slot.parcel_id]
          status_message.concat("#{id}\t\t#{parcel.code}\t\t\t#{parcel.weight}\n")   
        end
      end
      status_message
    end

    def self.slots_with_parcel_id(parcel_id)
      slot_ids = []
      all_by_id.each do |id, slot|
        slot_parcel_id = slot.parcel_id
        next if slot_parcel_id.nil?
        slot_ids.push(id) if slot_parcel_id == parcel_id
      end
      slot_ids
    end

    def self.slots_with_parcel_weight(weight)
      slot_ids = []
      parcel_ids = get_parcel_codes_with_weight(weight)
      all_by_id.each do |id, slot|
        slot_parcel_id = slot.parcel_id
        next if slot_parcel_id.nil?
        slot_ids.push(id) if parcel_ids.include?(slot_parcel_id)
      end
      slot_ids
    end

    private
      def self.nearest_available_parking_slot_id
        nearest_available_slot_id = nil
        allocation_order.each do |slot_1, slot_2|
          if slot_available?(slot_1)
            nearest_available_slot_id = slot_1
            break
          elsif slot_available?(slot_2)
            nearest_available_slot_id = slot_2
            break
          end
        end
        nearest_available_slot_id
      end

      def self.all_by_id
        @@parking_slots
      end

      def self.slot_available?(id)
        all_by_id[id].parcel_id.nil?
      end

      def self.parking_slots_count
        all_by_id.size
      end

      def self.allocation_order
        order = []
        1.upto(parking_slots_count/2).each do |slot_no|
          order.push([slot_no, nearest_slot(slot_no)])
        end
        order
      end

      def self.nearest_slot(given_slot)
        parking_slots_count - given_slot + 1
      end

      def self.get_parcels_by_id
        ::CourierFacility::Parcel.all_by_code
      end

      def self.get_parcel_codes_with_weight(weight)
        ::CourierFacility::Parcel.parcel_codes_with_weight(weight)
      end
	end
end

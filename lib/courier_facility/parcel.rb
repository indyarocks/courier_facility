module CourierFacility
	class Parcel
		attr_accessor :weight, :code

		def initialize(args)
			@code = args[:code]
			@weight = args[:weight]
		end

		def allocate_nearest_parcel_slot
		end
	end
end

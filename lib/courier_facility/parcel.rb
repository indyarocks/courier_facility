module CourierFacility
	class Parcel
		attr_accessor :weight, :code

    @@parcels = {}

		def initialize(args)
			@code = args[:code]
			@weight = args[:weight]
		end

    def self.create(code:, weight:)
      if all_by_code[code].nil?
        parcel = new(code: code, weight: weight)
        all_by_code[code] = parcel
      else
        raise ::CourierFacility::Error.new(self), "Parcel with code #{code} already exists!"
      end
      parcel
    end

    def self.all_by_code
      @@parcels
    end

    def self.parcel_codes_with_weight(weight)
      parcels_with_weight(weight).keys
    end

    private
      def self.parcels_with_weight(weight)
        all_by_code.select { |code, obj| obj.weight == weight }
      end
	end
end

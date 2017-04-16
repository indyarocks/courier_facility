require_relative 'command_preprocessor'
Dir[File.dirname(__FILE__) + '/courier_facility/*.rb'].each {|file| require file }

module CourierFacility
  class CourierFacility
    extend ::CourierFacility::CommandPreprocessor

    def self.process_command(command_text)
      execution_command_data = preprocess_text_command(command_text)
      execution_command, args = execution_command_data[:command], execution_command_data[:args]
      if execution_command.nil?
        raise ::CourierFacility::Error.new(self), 'invalid_command'
      end
      
      if execution_command != :create_parcel_slot_lot && !is_parking_lot_available?
        raise ::CourierFacility::Error.new(self), 'Please create a parcel slot lot with create_parcel_slot_lot <even slot size> command!'
      end
      ::CourierFacility::ParkingLot.instance.send(execution_command, args)
    end

    private

      def self.is_parking_lot_available?
        ::CourierFacility::ParkingLot.instance.rack_size > 0
      end
  end
end
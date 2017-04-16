RSpec.describe 'CommandPreprocessor' do 
  let(:dummy_class) { Class.new { extend ::CourierFacility::CommandPreprocessor } }

  it 'should trim the spaces around string' do
    expect(dummy_class.preprocess_text_command('  status ')[:command]).to eq(:status)
  end

  it 'should replace more than one space inside a command into single space' do
    expect(dummy_class.preprocess_text_command(' park   333   400 ')[:command]).to eq(:park)
  end

  it 'should downcase a command' do
    expect(dummy_class.preprocess_text_command(' SLot_number_for_registration_number 400 ')[:command]).to eq(:slot_number_for_registration_number)
  end

  context 'invalid commands' do 
    it 'should return {} for invalid command' do
      expect(dummy_class.preprocess_text_command('hello')[:command]).to be nil
      expect(dummy_class.preprocess_text_command('park 1234 400   6 ')[:command]).to be nil
      expect(dummy_class.preprocess_text_command('all_status ')[:command]).to be nil
      expect(dummy_class.preprocess_text_command(' parcel_code_for_parcels_with_weight ')[:command]).to be nil
      expect(dummy_class.preprocess_text_command(' slot_numbers_for_parcels_with_weight abc')[:command]).to be nil
      expect(dummy_class.preprocess_text_command(' slot_number_for_registration_number abc')[:command]).to be nil
    end
  end

  context 'valid commands' do
    it 'should return a match if valid command: create_parcel_slot_lot' do
      expect(dummy_class.preprocess_text_command('create_parcel_slot_lot  6 ')).to eq({
          command: :create_parcel_slot_lot,
          args: {required_rack_size: 6}
        })
    end

    it 'should return a match if valid command: park' do
      expect(dummy_class.preprocess_text_command('park 1234 400 ')).to eq({
          command: :park,
          args: {code: 1234, weight: 400}
        })
    end

    it 'should return a match if valid command: status' do
      expect(dummy_class.preprocess_text_command('status ')).to eq({
          command: :status,
          args: {}
        })
    end

    it 'should return a match if valid command: parcel_code_for_parcels_with_weight' do
      expect(dummy_class.preprocess_text_command('parcel_code_for_parcels_with_weight  600 ')).to eq({
          command: :parcel_code_for_parcels_with_weight,
          args: {weight: 600}
        })
    end

    it 'should return a match if valid command: slot_numbers_for_parcels_with_weight' do
      expect(dummy_class.preprocess_text_command(' slot_numbers_for_parcels_with_weight  600 ')).to eq({
          command: :slot_numbers_for_parcels_with_weight,
          args: {weight: 600}
        })
    end

    it 'should return a match if valid command: slot_number_for_registration_number' do
      expect(dummy_class.preprocess_text_command(' slot_number_for_registration_number  100 ')).to eq({
          command: :slot_number_for_registration_number,
          args: {code: 100}
        })
    end
  end  
end
RSpec.describe 'CommandPreprocessor' do 

  it 'should trim the spaces around string' do
    expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('  status ')[:match_command]).to eq(:status)
  end

  it 'should replace more than one space inside a command into single space' do
    expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' park   333   400 ')[:match_command]).to eq(:park)
  end

  it 'should downcase a command' do
    expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' SLot_number_for_registration_number 400 ')[:match_command]).to eq(:slot_number_for_registration_number)
  end

  context 'invalid commands' do 
    it 'should return {} for invalid command' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('hello')[:match_command]).to be nil
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('park 1234 400   6 ')[:match_command]).to be nil
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('all_status ')[:match_command]).to be nil
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' parcel_code_for_parcels_with_weight ')[:match_command]).to be nil
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' slot_numbers_for_parcels_with_weight abc')[:match_command]).to be nil
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' slot_number_for_registration_number abc')[:match_command]).to be nil
    end
  end

  context 'valid commands' do
    it 'should return a match if valid command: create_parking_slot_lot' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('create_parking_slot_lot  6 ')).to eq({
          match_command: :create_parking_slot_lot,
          args: {rack_size: 6}
        })
    end

    it 'should return a match if valid command: park' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('park 1234 400 ')).to eq({
          match_command: :park,
          args: {code: 1234, weight: 400}
        })
    end

    it 'should return a match if valid command: status' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('status ')).to eq({
          match_command: :status,
          args: {}
        })
    end

    it 'should return a match if valid command: parcel_code_for_parcels_with_weight' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('parcel_code_for_parcels_with_weight  600 ')).to eq({
          match_command: :parcel_code_for_parcels_with_weight,
          args: {weight: 600}
        })
    end

    it 'should return a match if valid command: slot_numbers_for_parcels_with_weight' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' slot_numbers_for_parcels_with_weight  600 ')).to eq({
          match_command: :slot_numbers_for_parcels_with_weight,
          args: {weight: 600}
        })
    end

    it 'should return a match if valid command: slot_number_for_registration_number' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' slot_number_for_registration_number  100 ')).to eq({
          match_command: :slot_number_for_registration_number,
          args: {code: 100}
        })
    end
  end  
end
RSpec.describe 'CommandPreprocessor' do 

  it 'should trim the spaces around string' do
    expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('  PArk   333   400  ')).to eq('park 333 400')
  end

  it 'should replace more than one space inside a command into single space' do
    expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' park   333   400 ')).to eq('park 333 400')
  end

  it 'should downcase a command' do
    expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' PArk   333   400 ')).to eq('park 333 400')
  end

  context 'invalid commands' do 
    it 'should return error for invalid command' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('hello')).to be nil
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('park 1234 400   6 ')).to be nil
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('all_status ')).to be nil
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' parcel_code_for_parcels_with_weight ')).to be nil
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' slot_numbers_for_parcels_with_weight abc')).to be nil
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' slot_number_for_registration_number abc')).to be nil
    end
  end

  context 'valid commands' do
    it 'should return a match if valid command: create_parcel_slot_lot' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('create_parcel_slot_lot  6 ')).to eq('create_parcel_slot_lot 6')
    end

    it 'should return a match if valid command: park' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('park 1234 400 ')).to eq('park 1234 400')
    end

    it 'should return a match if valid command: status' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('status ')).to eq('status')
    end

    it 'should return a match if valid command: create_parcel_slot_lot' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command('parcel_code_for_parcels_with_weight  600 ')).to eq('parcel_code_for_parcels_with_weight 600')
    end

    it 'should return a match if valid command: create_parcel_slot_lot' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' slot_numbers_for_parcels_with_weight  600 ')).to eq('slot_numbers_for_parcels_with_weight 600')
    end

    it 'should return a match if valid command: create_parcel_slot_lot' do
      expect(::CourierFacility::CommandPreprocessor.preprocess_text_command(' slot_number_for_registration_number  100 ')).to eq('slot_number_for_registration_number 100')
    end
  end  
end
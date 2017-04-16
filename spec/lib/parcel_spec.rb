RSpec.describe 'Parcel' do 
  let(:parcel) { CourierFacility::Parcel.new(code: 100, weight: 200) }

	it 'should have weight' do
    expect(parcel.weight).to eq(200)
  end

  it 'should have registration code' do
    expect(parcel.code).to eq(100)
  end
end
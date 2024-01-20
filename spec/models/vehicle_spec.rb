# frozen_string_literal: true

RSpec.describe Vehicle do
  let(:vehicle) { build(:vehicle) }

  describe 'validations' do
    it 'is valid from the factory' do
      expect(vehicle).to be_valid
    end

    it 'is invalid without a VIN' do
      vehicle.vin = nil
      expect(vehicle).not_to be_valid
    end

    it 'is invalid without a make' do
      vehicle.make = nil
      expect(vehicle).not_to be_valid
    end

    it 'is invalid without a model' do
      vehicle.model = nil
      expect(vehicle).not_to be_valid
    end

    it 'is invalid without a year' do
      vehicle.year = nil
      expect(vehicle).not_to be_valid
    end

    it 'is invalid with a year that is too far in the future' do
      vehicle.year = Date.current.year + 2
      expect(vehicle).not_to be_valid
    end

    it 'is invalid with a year that is too far in the past' do
      vehicle.year = described_class::STARTING_YEAR - 1
      expect(vehicle).not_to be_valid
    end

    it 'is invalid if the VIN already exists in the database' do
      vehicle.save
      new_vehicle = build(:vehicle, vin: vehicle.vin)

      expect(new_vehicle).not_to be_valid
    end
  end

  describe 'associations' do
    let!(:vehicle) do
      v = create(:vehicle)
      create_list(:log_entry, 3, vehicle: v)

      v
    end

    it 'destroys associated log_entry records when the vehicle record is destroyed' do
      expect do
        vehicle.destroy!
      end.to change(described_class, :count).by(-1).and change(LogEntry, :count).by(-3)
    end
  end
end

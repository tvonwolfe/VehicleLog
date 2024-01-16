# frozen_string_literal: true

RSpec.describe LogEntry do
  let(:log_entry) { build(:log_entry) }

  describe 'validations' do
    it 'is valid from the factory' do
      expect(log_entry).to be_valid
    end

    it 'is invalid without a vehicle' do
      log_entry.vehicle = nil
      expect(log_entry).not_to be_valid
    end

    it 'is invalid without a title' do
      log_entry.title = nil
      expect(log_entry).not_to be_valid
    end

    it 'is invalid without a performed_on date' do
      log_entry.performed_on = nil
      expect(log_entry).not_to be_valid
    end

    it 'is invalid if the performed_on date is in the future' do
      log_entry.performed_on = Date.current + 1.day

      expect(log_entry).not_to be_valid
    end

    it 'is invalid without a recorded_mileage' do
      log_entry.recorded_mileage = nil
      expect(log_entry).not_to be_valid
    end

    it 'is invalid with a negative recorded_mileage' do
      log_entry.recorded_mileage *= -1

      expect(log_entry).not_to be_valid
    end

    it 'is invalid if the cost is < 0' do
      log_entry.cost = -1
      expect(log_entry).not_to be_valid
    end
  end

  describe '#formatted_mileage' do
    it 'returns the current mileage with comma delimiters' do
      log_entry.recorded_mileage = 1_234_567
      expect(log_entry.formatted_mileage).to eq '1,234,567'
    end
  end
end

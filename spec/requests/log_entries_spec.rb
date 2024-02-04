# frozen_string_literal: true

RSpec.describe 'LogEntries' do
  let(:user) { create(:user) }
  let(:auth_token) { user.generate_auth_token.encode! }
  let(:headers) { { Authorization: auth_token } }
  # This should return the minimal set of attributes required to create a valid
  # LogEntry. As you add validations to LogEntry, be sure to
  # adjust the attributes here as well.

  describe 'GET /vehicles/:vehicle_id/log_entries' do
    let(:vehicle) do
      v = create(:vehicle)
      create_list(:log_entry, 3, vehicle: v)

      v
    end

    before do
      get vehicle_log_entries_path(vehicle), headers:
    end

    it_behaves_like 'an HTTP 200 response'
    it_behaves_like 'an expected view template', :index
    it_behaves_like 'an authenticated route'
  end

  describe 'GET /log_entries/:id' do
    let(:log_entry) { create(:log_entry) }

    before do
      get log_entry_path(log_entry), headers:
    end

    it_behaves_like 'an HTTP 200 response'
    it_behaves_like 'an expected view template', :show
    it_behaves_like 'an authenticated route'
  end

  describe 'GET /log_entries/new' do
    let(:vehicle) { create(:vehicle) }

    before do
      get new_vehicle_log_entry_path(vehicle), headers:
    end

    it_behaves_like 'an HTTP 200 response'
    it_behaves_like 'an expected view template', :new
    it_behaves_like 'an authenticated route'
  end

  describe 'GET log_entries/:id/edit' do
    let(:vehicle) { create(:vehicle) }
    let(:log_entry) { create(:log_entry, vehicle:) }

    before do
      get edit_log_entry_path(log_entry), headers:
    end

    it_behaves_like 'an HTTP 200 response'
    it_behaves_like 'an expected view template', :edit
    it_behaves_like 'an authenticated route'
  end

  describe 'POST vehicles/:vehicle_id/log_entries' do
    let(:vehicle) { create(:vehicle) }
    let(:params) { { log_entry: attributes_for(:log_entry) } }

    before do
      post vehicle_log_entries_path(vehicle), headers:, params:
    end

    it_behaves_like 'an HTTP 302 response'
    it_behaves_like 'an authenticated route'

    it 'creates a new log entry' do
      log_entry_params = { log_entry: attributes_for(:log_entry) }
      expect do
        post vehicle_log_entries_path(vehicle), headers:, params: log_entry_params
      end.to change(LogEntry, :count).by 1
    end

    context 'when required params are missing' do
      let(:params) { { log_entry: attributes_for(:log_entry).except(:performed_on) } }

      it_behaves_like 'an HTTP 422 response'
      it_behaves_like 'an expected view template', :new
    end

    context 'when params are invalid' do
      let(:params) { { log_entry: attributes_for(:log_entry).merge(recorded_mileage: true) } }

      it_behaves_like 'an HTTP 422 response'
      it_behaves_like 'an expected view template', :new
    end
  end

  describe 'PATCH /log_entries/:id' do
    let(:log_entry) { create(:log_entry) }
    let(:params) do
      {
        log_entry: {
          performed_on: Date.yesterday,
          recorded_mileage: 100_000,
          cost: 50
        }
      }
    end

    before do
      patch log_entry_path(log_entry), headers:, params:
    end

    it_behaves_like 'an HTTP 302 response'
    it_behaves_like 'an authenticated route'

    context 'when params are invalid' do
      let(:params) { { log_entry: { recorded_mileage: true } } }

      it_behaves_like 'an HTTP 422 response'
      it_behaves_like 'an expected view template', :edit
    end
  end

  describe 'DELETE /destroy' do
    let(:log_entry) { create(:log_entry) }

    before do
      delete log_entry_path(log_entry), headers:
    end

    it_behaves_like 'an HTTP 302 response'
    it_behaves_like 'an authenticated route'

    it "redirects to the deleted log entry's vehicle page" do
      expect(response).to redirect_to vehicle_path(log_entry.vehicle)
    end
  end
end

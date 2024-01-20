# frozen_string_literal: true

RSpec.describe 'Vehicles' do
  let(:user) { create(:user) }
  let(:auth_token) { user.generate_auth_token.encode! }
  let(:headers) { { Authorization: auth_token } }

  describe 'GET /vehicles' do
    let(:vehicles) { create_list(:vehicle, 3) }

    before do
      get vehicles_path, headers:
    end

    it_behaves_like 'a successful request'
    it_behaves_like 'an ok (200) response'
    it_behaves_like 'an expected view template', :index
    it_behaves_like 'an authenticated route'
  end

  describe 'GET /vehicles/:id' do
    let(:vehicle) { create(:vehicle) }

    before do
      get vehicle_path(vehicle), headers:
    end

    it_behaves_like 'a successful request'
    it_behaves_like 'an ok (200) response'
    it_behaves_like 'an expected view template', :show
    it_behaves_like 'an authenticated route'
  end

  describe 'GET /vehicles/new' do
    before do
      get new_vehicle_path, headers:
    end

    it_behaves_like 'a successful request'
    it_behaves_like 'an ok (200) response'
    it_behaves_like 'an expected view template', :new
    it_behaves_like 'an authenticated route'
  end

  describe 'GET /vehicles/:id/edit' do
    let(:vehicle) { create(:vehicle) }

    before do
      get edit_vehicle_path(vehicle), headers:
    end

    it_behaves_like 'a successful request'
    it_behaves_like 'an ok (200) response'
    it_behaves_like 'an expected view template', :edit
    it_behaves_like 'an authenticated route'
  end

  describe 'POST /vehicles' do
    let(:params) { { vehicle: attributes_for(:vehicle) } }

    before do
      post vehicles_path, headers:, params:
    end

    it_behaves_like 'a found (302) response'
    it_behaves_like 'an authenticated route'

    it "redirects to the newly-created vehicle's page" do
      vehicle = create(:vehicle)
      allow(Vehicle).to receive(:new).and_return(vehicle)
      post(vehicles_path, headers:, params:)

      expect(response).to redirect_to vehicle_path(vehicle)
    end

    it 'creates a new vehicle' do
      vehicle_params = { vehicle: attributes_for(:vehicle) }

      expect do
        post vehicles_path, headers:, params: vehicle_params
      end.to change(Vehicle, :count).by 1
    end

    context 'when required params are missing' do
      let(:params) { { vehicle: attributes_for(:vehicle).except(:make) } }

      it_behaves_like 'an unprocessable entity (422) response'
      it_behaves_like 'an expected view template', :new
    end

    context 'when params are invalid' do
      let(:params) { { vehicle: attributes_for(:vehicle).merge(year: 'nineteen seventy-five') } }

      it_behaves_like 'an unprocessable entity (422) response'
      it_behaves_like 'an expected view template', :new
    end
  end

  describe 'PATCH /vehicles/:id' do
    let(:vehicle) { create(:vehicle) }
    let(:params) { { vehicle: { make: 'BMW' } } }

    before do
      patch vehicle_path(vehicle), headers:, params:
    end

    it_behaves_like 'an internal redirect', :vehicle
    it_behaves_like 'an authenticated route'

    it 'updates specified attributes of the vehicle' do
      expect(vehicle.reload.make).to eq 'BMW'
    end

    context 'when params are invalid' do
      let(:params) { { vehicle: { year: 'nineteen seventy-five' } } }

      it_behaves_like 'an unprocessable entity (422) response'
      it_behaves_like 'an expected view template', :edit
    end
  end

  describe 'DELETE /vehicles/:id' do
    let(:vehicle) { create(:vehicle) }

    before do
      delete vehicle_path(vehicle), headers:
    end

    it_behaves_like 'a found (302) response'
    it_behaves_like 'an authenticated route'
    it_behaves_like 'an internal redirect', :vehicles

    it 'destroys the specified vehicle' do
      other_vehicle = create(:vehicle)
      expect do
        delete vehicle_path(other_vehicle), headers:
      end.to change(Vehicle, :count).by(-1)
      expect(Vehicle.exists?(other_vehicle.id)).to be false
    end
  end
end

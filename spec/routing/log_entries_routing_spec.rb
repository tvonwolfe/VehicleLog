# frozen_string_literal: true

RSpec.describe LogEntriesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'vehicles/1/log_entries').to route_to('log_entries#index', vehicle_id: '1')
    end

    it 'routes to #new' do
      expect(get: 'vehicles/1/log_entries/new').to route_to('log_entries#new', vehicle_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/log_entries/1').to route_to('log_entries#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/log_entries/1/edit').to route_to('log_entries#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: 'vehicles/1/log_entries').to route_to('log_entries#create', vehicle_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/log_entries/1').to route_to('log_entries#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/log_entries/1').to route_to('log_entries#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/log_entries/1').to route_to('log_entries#destroy', id: '1')
    end
  end
end

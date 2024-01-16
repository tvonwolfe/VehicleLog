# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/log_entries' do
  # This should return the minimal set of attributes required to create a valid
  # LogEntry. As you add validations to LogEntry, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      LogEntry.create! valid_attributes
      get log_entries_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      log_entry = LogEntry.create! valid_attributes
      get log_entry_url(log_entry)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_log_entry_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      log_entry = LogEntry.create! valid_attributes
      get edit_log_entry_url(log_entry)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new LogEntry' do
        expect do
          post log_entries_url, params: { log_entry: valid_attributes }
        end.to change(LogEntry, :count).by(1)
      end

      it 'redirects to the created log_entry' do
        post log_entries_url, params: { log_entry: valid_attributes }
        expect(response).to redirect_to(log_entry_url(LogEntry.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new LogEntry' do
        expect do
          post log_entries_url, params: { log_entry: invalid_attributes }
        end.not_to change(LogEntry, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post log_entries_url, params: { log_entry: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested log_entry' do
        log_entry = LogEntry.create! valid_attributes
        patch log_entry_url(log_entry), params: { log_entry: new_attributes }
        log_entry.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the log_entry' do
        log_entry = LogEntry.create! valid_attributes
        patch log_entry_url(log_entry), params: { log_entry: new_attributes }
        log_entry.reload
        expect(response).to redirect_to(log_entry_url(log_entry))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        log_entry = LogEntry.create! valid_attributes
        patch log_entry_url(log_entry), params: { log_entry: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested log_entry' do
      log_entry = LogEntry.create! valid_attributes
      expect do
        delete log_entry_url(log_entry)
      end.to change(LogEntry, :count).by(-1)
    end

    it 'redirects to the log_entries list' do
      log_entry = LogEntry.create! valid_attributes
      delete log_entry_url(log_entry)
      expect(response).to redirect_to(log_entries_url)
    end
  end
end

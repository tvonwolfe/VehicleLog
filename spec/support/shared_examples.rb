# frozen_string_literal: true

shared_examples 'a successful request' do
  it 'returns success' do
    expect(response).to be_successful
  end
end

shared_examples 'an ok (200) response' do
  it 'returns ok' do
    expect(response).to have_http_status(:ok)
  end
end

shared_examples 'a no content (204) response' do
  it 'returns no content' do
    expect(response).to have_http_status(:no_content)
  end
end

shared_examples 'a found (302) response' do
  it 'returns found' do
    expect(response).to have_http_status(:found)
  end
end

shared_examples 'an unauthorized (401) response' do
  it 'returns unauthorized' do
    expect(response).to have_http_status(:unauthorized)
  end
end

shared_examples 'an unprocessable entity (422) response' do
  it 'returns unprocessable_entity' do
    expect(response).to have_http_status(:unprocessable_entity)
  end
end

shared_examples 'an internal redirect' do |redirect_path|
  it 'redirects to the correct path' do
    expect(response).to redirect_to redirect_path
  end
end

shared_examples 'an expected view template' do |template_name|
  it 'renders the proper view template' do
    expect(response).to render_template(template_name)
  end
end

shared_examples 'an authenticated route' do
  context 'when user is not authenticated' do
    let(:headers) { {} }

    it_behaves_like 'a found (302) response'
    it_behaves_like 'an internal redirect', :login_authentication_index
  end
end

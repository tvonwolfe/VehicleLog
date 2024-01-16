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

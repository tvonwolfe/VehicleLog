# frozen_string_literal: true

RSpec.describe 'Authentication', type: :request do
  let(:password) { Faker::Alphanumeric.alphanumeric(number: 12) }
  let(:user) { create(:user, password:) }
  let(:params) { { email: user.email, password: } }

  describe 'POST /authentication/login.json' do
    before do
      post '/authentication/login.json', params:
    end

    it_behaves_like 'a successful request'
    it_behaves_like 'an ok (200) response'

    it 'responds with a valid auth token for the authenticated user' do
      token = Authentication::Token.decode(response.parsed_body['token'])
      expect(token.uid).to eq(user.id)
      expect(token).to be_valid
    end

    it 'includes the auth token as a cookie in the response' do
      token = Authentication::Token.decode(response.cookies['Authorization'])
      expect(token.uid).to eq(user.id)
      expect(token).to be_valid
    end
  end

  describe 'GET /authentication/logout.json' do
    let(:encoded_token) { user.generate_auth_token.encode! }

    before do
      cookies['Authorization'] = encoded_token
      get '/authentication/logout.json'
    end

    it 'removes the auth token from cookies' do
      expect(response.cookies['Authorization']).to be_blank
    end

    it_behaves_like 'a successful request'
    it_behaves_like 'a no content (204) response'
  end
end

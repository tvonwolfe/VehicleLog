# frozen_string_literal: true

# authentication module for controllers
module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :set_user

    # @return [User]
    attr_reader :current_user

    # @return [Token]
    attr_reader :token

    helper_method :current_user, :logged_in?

    rescue_from CanCan::AccessDenied, with: :handle_authorization_error
  end

  def logged_in?
    current_user.present?
  end

  private

  def set_user
    return unless auth_token.present? && auth_token.valid?

    @current_user = User.find(auth_token.uid)
  end

  # @return [Token,nil] - decoded, deserialized JWT
  def auth_token
    return if encoded_auth_token.blank?

    @auth_token ||= Token.decode(encoded_auth_token)
  rescue Token::Invalid => e
    Rails.logger.info(self.class.name) { "#{e.class}: #{e.full_message}" }
    nil
  end

  def encoded_auth_token
    cookies['Authorization'] || request.authorization
  end

  def auth_cookie
    cookies['Authorization']
  end

  def handle_authorization_error
    respond_to do |format|
      format.json do
        render json: { error: 'Not authorized. Authorization header is missing or invalid.' }, status: :unauthorized
      end

      format.html { redirect_to login_authentication_index_path }
    end
  end
end

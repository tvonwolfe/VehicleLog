# frozen_string_literal: true

# controller for authentication
class AuthenticationController < ApplicationController
  skip_before_action :set_user, only: :login
  before_action :find_user, only: :login

  def show
    if logged_in?
      redirect_to :root
    else
      render LoginComponent.new
    end
  end

  def login
    authenticate_with_password!

    auth_token = current_user.generate_auth_token
    cookies['Authorization'] = auth_token.to_cookie!

    respond_to do |format|
      format.html { redirect_to :root }
      format.json { render json: { token: cookies['Authorization'] }, status: :ok }
    end
  end

  def logout
    cookies.delete('Authorization')
    respond_to do |format|
      format.html { redirect_to login_authentication_index_path }
      format.json { head :no_content }
    end
  end

  private

  def find_user
    @current_user = User.find_by(email: login_params[:email])
  end

  def login_params
    params.permit %i[email password]
  end

  def authenticate_with_password!
    return if current_user&.authenticate(login_params.fetch(:password))

    respond_to do |format|
      format.html { render LoginComponent.new(error: 'Invalid username or password.'), status: :bad_request }
      format.json { render json: { error: 'Invalid username or password.' }, status: :bad_request }
    end
  end
end

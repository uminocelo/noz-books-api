class ApplicationController < ActionController::API
  include JwtTokenManager

  before_action :require_token

  private

  def require_token
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    @decode = JwtTokenManager.token_decoder(header)
    render json: { message: e.message }, status: :unauthorized unless @decode[:email].end_with?('@noz.com.br')
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :unauthorized
  rescue JWT::DecodeError => e
    render json: { message: e.message }, status: :unauthorized
  end
end

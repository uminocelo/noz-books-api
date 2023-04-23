class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :require_token

  include JwtTokenManager

  # POST /api/v1/auth
  def auth
    @email = params[:email]
    return render json: { message: 'Sem autorização' }, status: :unauthorized unless @email.end_with?('@noz.com.br')

    time = Time.now + 24.hours.to_i
    @token = JwtTokenManager.token_encoder({ email: @email })
    render json: { token: @token, exp: time.strftime("%m-%d-%Y %H:%M"), email: @email }, status: :ok
  end
end

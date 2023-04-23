# frozen_string_literal: true

require 'jwt'

# docs
module JwtTokenManager
  extend ActiveSupport::Concern

  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.token_encoder(payload, exp: 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.token_decoder(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  end
end

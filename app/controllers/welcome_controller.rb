class WelcomeController < ApplicationController
  def index
    render json: { message: "Hello World :)" }, status: :ok
  end
end

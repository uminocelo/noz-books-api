# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :books, except: %i[create update destroy]

      resources :authors do
        resources :books, only: %i[create update destroy]
      end
    end
  end

  root 'welcome#index'
end

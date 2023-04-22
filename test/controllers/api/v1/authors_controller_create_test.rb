# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthorsController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_attributes) { FactoryBot.attributes_for(:author) }

      it 'creates a new author' do
        expect do
          post :create, params: { author: valid_attributes }
        end.to change(Author, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: { author: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { FactoryBot.attributes_for(:author, name: '') }

      it 'returns a conflict response' do
        post :create, params: { author: invalid_attributes }
        expect(response).to have_http_status(409)
      end

      it 'returns an error message' do
        post :create, params: { author: invalid_attributes }
        expect(JSON.parse(response.body)['message']).to eq('Não foi possivel criar este autor.')
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthorsController, type: :controller do
  describe 'PUT #update' do
    let(:author) { FactoryBot.create(:author) }

    context 'with valid params' do
      let(:new_attributes) { FactoryBot.attributes_for(:author, name: 'New Name') }

      it 'updates the requested author' do
        put :update, params: { id: author.to_param, author: new_attributes }
        author.reload
        expect(author.name).to eq('New Name')
      end

      it 'returns a success response' do
        put :update, params: { id: author.to_param, author: new_attributes }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { FactoryBot.attributes_for(:author, name: '') }

      it 'returns a not found response' do
        put :update, params: { id: author.to_param, author: invalid_attributes }
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        put :update, params: { id: author.to_param, author: invalid_attributes }
        expect(JSON.parse(response.body)['message']).to eq('Não foi possivel atualizar este autor.')
      end
    end
  end
end

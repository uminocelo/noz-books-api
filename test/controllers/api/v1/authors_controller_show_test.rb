# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::AuthorsController, type: :controller do
  describe 'GET #show' do
    let(:author) { FactoryBot.create(:author) }

    it 'returns a success response' do
      get :show, params: { id: author.to_param }
      expect(response).to be_successful
    end

    it 'returns the correct author' do
      get :show, params: { id: author.to_param }
      expect(JSON.parse(response.body)).to eq(JSON.parse(author.to_json))
    end
  end
end
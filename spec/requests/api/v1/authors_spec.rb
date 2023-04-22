require 'swagger_helper'

RSpec.describe 'api/v1/authors', type: :request do
  path '/api/v1/authors' do
    get('list authors') do
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create author') do
      response(201, 'successful') do
        consumes('application/json')
        parameter(name: :author, in: :body, schema:
          {
            type: :object,
            properties: {
              name: { type: :string },
              birthday: { type: :string, format: :date },
              main_genre: { type: :string }
            },
            required: %w[name birthday main_genre]
          })

        let(:author) { FactoryBot.attributes_for(:author) }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/authors/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show author') do
      response(200, 'successful') do
        tags('Authors')
        produces('application/json')
        parameter(name: :id, in: :path, type: :integer)

        let(:author) { create(:author) }
        let(:id) { author.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update author') do
      response(200, 'successful') do
        consumes('application/json')
        parameter(name: :author, in: :body, schema:
          {
            type: :object,
            properties: {
              name: { type: :string },
              birthday: { type: :string, format: :date },
              main_genre: { type: :string }
            },
            required: %w[name birthday main_genre]
          })

        let(:author) { create(:author) }
        let(:id) { author.id }
        let(:author_params) { { name: 'New Author Name' } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete author') do
      response(204, 'successful') do
        tags('Authors')
        produces('application/json')
        parameter(name: :id, in: :path, type: :integer)

        let(:author) { create(:author) }
        let(:id) { author.id }

        run_test!
      end
    end
  end
end

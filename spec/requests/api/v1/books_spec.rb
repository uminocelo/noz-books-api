require 'swagger_helper'

RSpec.describe 'api/v1/books', type: :request do
  path '/api/v1/books' do
    get('list books') do
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
  end

  path '/api/v1/books/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show book') do
      response(200, 'successful') do
        tags('Books')
        produces('application/json')
        parameter(name: :id, in: :path, type: :integer)

        let(:book) { create(:book) }
        let(:id) { book.id }

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

  path '/api/v1/authors/{author_id}/books' do
    parameter name: 'author_id', in: :path, type: :string, description: 'Author id'

    post('create book') do
      response(201, 'successful') do
        tags('Books')
        consumes('application/json')
        parameter(name: :author_id, in: :path, type: :integer, required: true)
        parameter(name: :book, in: :body, schema:
        {
          type: :object,
          properties: {
            title: { type: :string },
            description: { type: :string },
            genre: { type: :string },
            publication_date: { type: :string, format: :date },
            publisher: { type: :string }
          },
          required: %w[title]
        })

        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:book) { FactoryBot.attributes_for(:book) }

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

  path '/api/v1/authors/{author_id}/books/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'author_id', in: :path, type: :string, description: 'author_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    patch('update book') do
      response(200, 'successful') do
        tags('Books')
        consumes('application/json')
        parameter(name: :author_id, in: :path, type: :integer, required: true)
        parameter(name: :id, in: :path, type: :integer, required: true)
        parameter(name: :book, in: :body, schema:
        {
          type: :object,
          properties: {
            title: { type: :string },
            description: { type: :string },
            genre: { type: :string },
            publication_date: { type: :string, format: :date },
            publisher: { type: :string }
          },
          required: %w[title]
        })

        let(:book) { FactoryBot.create(:book, :with_author) }
        let(:author_id) { book.author.id }
        let(:id) { book.id }
        let(:book_params) { { title: 'New Title' } }

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

    delete('delete book') do
      response(204, 'successful') do
        tags('Author')
        produces('application/json')
        parameter(name: :author_id, in: :path, type: :integer, required: true)
        parameter(name: :id, in: :path, type: :integer, required: true)

        let(:book) { FactoryBot.create(:book, :with_author) }
        let(:author_id) { book.author.id }
        let(:id) { book.id }

        run_test!
      end
    end
  end
end

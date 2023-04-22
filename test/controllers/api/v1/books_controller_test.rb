require 'rails_helper'

RSpec.describe Api::V1::BooksController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns all books' do
      books = create_list(:book, 3)
      get :index
      expect(assigns(:books)).to match_array(books)
    end

    it 'returns 500 when there is an error' do
      allow(Book).to receive(:all).and_raise(StandardError)
      get :index
      expect(response).to have_http_status(500)
    end
  end

  describe 'GET #show' do
    let(:book) { create(:book) }

    it 'returns a success response' do
      get :show, params: { id: book.id }
      expect(response).to be_successful
    end

    it 'returns the correct book' do
      get :show, params: { id: book.id }
      expect(assigns(:book)).to eq(book)
    end

    it 'returns 404 when the book does not exist' do
      get :show, params: { id: 'invalid_id' }
      expect(response).to have_http_status(404)
    end

    it 'returns 500 when there is an error' do
      allow(Book).to receive(:find).and_raise(StandardError)
      get :show, params: { id: book.id }
      expect(response).to have_http_status(500)
    end
  end

  describe 'POST #create' do
    let(:author) { create(:author) }
    let(:valid_attributes) { attributes_for(:book) }
    let(:invalid_attributes) { attributes_for(:book, title: nil) }

    context 'with valid attributes' do
      it 'creates a new book' do
        expect {
          post :create, params: { author_id: author.id, book: valid_attributes }
        }.to change(Book, :count).by(1)
      end

      it 'returns a success response' do
        post :create, params: { author_id: author.id, book: valid_attributes }
        expect(response).to have_http_status(201)
      end

      it 'returns the created book' do
        post :create, params: { author_id: author.id, book: valid_attributes }
        expect(assigns(:books)).to be_an_instance_of(Book)
        expect(assigns(:books)).to be_persisted
        expect(assigns(:books).title).to eq(valid_attributes[:title])
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new book' do
        expect {
          post :create, params: { author_id: author.id, book: invalid_attributes }
        }.to_not change(Book, :count)
      end

      it 'returns a conflict response' do
        post :create, params: { author_id: author.id, book: invalid_attributes }
        expect(response).to have_http_status(409)
      end
    end

    it 'returns 500 when there is an error' do
      allow(Author).to receive_message_chain(:find, :books, :create).and_raise(StandardError)
      post :create, params: { author_id: author.id, book: valid_attributes }
      expect(response).to have_http_status(500)
    end
  end

  describe 'PUT #update' do
    let!(:author) { create(:author) }
    let!(:book) { create(:book, author: author) }
    let(:updated_title) { 'New Title' }
    let(:valid_attributes) { { book: { title: updated_title } } }

    context 'when the book exists' do
      context 'with valid parameters' do
        it 'updates the book' do
          put :update, params: { author_id: author.id, id: book.id }.merge(valid_attributes)
          expect(response).to have_http_status(:ok)
          expect(book.reload.title).to eq(updated_title)
        end
      end

      context 'with invalid parameters' do
        let(:invalid_attributes) { { book: { title: nil } } }

        it 'does not update the book' do
          put :update, params: { author_id: author.id, id: book.id }.merge(invalid_attributes)
          expect(response).to have_http_status(:not_found)
          expect(book.reload.title).not_to eq(nil)
        end
      end
    end

    context 'when the book does not exist' do
      it 'returns a 404 status code' do
        put :update, params: { author_id: author.id, id: 'invalid' }.merge(valid_attributes)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:book) { create(:book) }

    context 'when the book exists' do
      it 'deletes the book' do
        expect do
          delete :destroy, params: { id: book.id }
        end.to change(Book, :count).by(-1)
      end

      it 'returns a success response' do
        delete :destroy, params: { id: book.id }
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when the book does not exist' do
      it 'returns a not found response' do
        delete :destroy, params: { id: 'invalid_id' }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when an exception is raised' do
      before do
        allow_any_instance_of(Book).to receive(:destroy).and_raise(StandardError.new('Some error'))
      end

      it 'returns an internal server error response' do
        delete :destroy, params: { id: book.id }
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end

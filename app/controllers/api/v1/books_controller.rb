class Api::V1::BooksController < ApplicationController
  skip_before_action :require_token, only: %i[index show]

  before_action :find_book, only: %i[show destroy]
  before_action :find_author, only: %i[create destroy]

  def index
    @books = Book.all
    render json: @books, status: :ok
  rescue StandardError => _e
    render json: { message: e.message }, status: 500
  end

  def show
    render json: @book, status: :ok
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end

  def create
    @books = @author.books.create(books_params)
    return render json: { message: 'Book registered successfully.' }, status: 201 unless @books.id.nil?

    render json: { message: 'Unable to create this book.' }, status: 409
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end

  def update
    @book = @author.books.find(params[:id])
    return render json: { message: 'Book updated successfully!' }, status: :ok if @book.update(books_params)

    render json: { message: 'Unable to update this book.' }, status: 404
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end

  def destroy
    @book.destroy
    render json: { message: 'Book deleted successfully.' }, status: 204
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end

  private

  def books_params
    params.require(:book).permit(:title, :description, :genre, :publication_date, :publisher)
  end

  def find_book
    @book = Book.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  end

  def find_author
    @author = Author.find(params[:author_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  end
end

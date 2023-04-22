class Api::V1::BooksController < ApplicationController
  def index
    @books = Book.all
    render json: @books, status: :ok
  rescue StandardError => _e
    render json: { message: 'Erro ao encontrar livros...' } , status: 500
  end

  def show
    @book = Book.find(params[:id])
    render json: @book, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  rescue StandardError => e
    render json: e.message, status: 500
  end

  def create
    @author = Author.find(params[:author_id])
    @books = @author.books.create(books_params)
    return render json: { message: 'Livro cadastrado com sucesso.' }, status: 201 unless @books.id.nil?

    render json: { message: 'Não foi possivel cadastrar este livro.' }, status: 409
  rescue StandardError => e
    render json: e.message, status: 500
  end

  def update
    @author = Author.find(params[:author_id])
    @book = @author.books.find(params[:id])
    return render json: { message: 'Livro atualizado com sucesso!' }, status: :ok if @book.update(books_params)

    render json: { message: 'Não foi possivel atualizar este livro.' }, status: 404
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    render json: { message: 'Livro excluído com sucesso.' }, status: 204
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  rescue StandardError => e
    render json: e.message, status: 500
  end

  private

  def books_params
    params.require(:book).permit(:title, :description, :genre, :publication_date, :publisher)
  end
end

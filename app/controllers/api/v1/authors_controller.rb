class Api::V1::AuthorsController < ApplicationController
  def index
    @authors = Author.all
    render json: @authors, status: :ok
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end

  def create
    @author = Author.new(authors_params)

    if @author.save
      render json: { message: 'Autor criado com sucesso!' }, status: :created
    else
      render json: { message: 'Não foi possível criar este autor.' }, status: :unprocessable_entity
    end
  rescue StandardError => _e
    render json: { message: 'Não foi possivel criar este autor.' }, status: 500
  end

  def show
    @author = Author.find(params[:id])
    render json: @author, status: :ok
  end

  def update
    @author = Author.find(params[:id])
    return render json: { message: 'Autor atualizado com sucesso!' }, status: :ok if @author.update(authors_params)

    render json: { message: 'Não foi possivel atualizar este autor.' }, status: 404
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    render json: { message: 'Autor excluído com sucesso.' }, status: 204
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end

  private

  def authors_params
    params.require(:author).permit(:name, :birthday, :main_genre)
  end
end

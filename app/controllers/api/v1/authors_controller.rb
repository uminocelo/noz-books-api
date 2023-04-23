class Api::V1::AuthorsController < ApplicationController
  skip_before_action :require_token, only: %i[index show]

  before_action :find_author, only: %i[show update destroy]

  def index
    @authors = Author.all
    render json: @authors, status: :ok
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end

  def show
    render json: @author, status: :ok
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end

  def create
    @author = Author.new(authors_params)

    if @author.save
      render json: { message: 'Author successfully created!' }, status: :created
    else
      render json: { message: 'Unable to create this author.' }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end

  def update
    return render json: { message: 'Author successfully updated!' }, status: :ok if @author.update(authors_params)

    render json: { message: 'Unable to update this author.' }, status: 404
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end

  def destroy
    @author.destroy
    render json: { message: 'Author deleted successfully.' }, status: 204
  rescue StandardError => e
    render json: { message: e.message }, status: 500
  end

  private

  def authors_params
    params.require(:author).permit(:name, :birthday, :main_genre)
  end

  def find_author
    @author = Author.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: 404
  end
end

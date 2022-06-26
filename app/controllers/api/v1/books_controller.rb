class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: %i[ show update destroy ]
  ALLOWED_DATA = %[title, author, description, price].freeze

  # GET /books
  def index
    @books = Book.all

    render json: @books
  end

  # GET /books/1
  def show
    render json: @book
  end

  # POST /books
  def create
    data = json_payload.select {|item| ALLOWED_DATA.include?(item)}
    @book = Book.new(data)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    data = json_payload.select {|item| ALLOWED_DATA.include?(item)}
    if @book.update(data)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def book_params
    #   params.require(:book).permit(:title, :author, :description, :price)
    # end
end

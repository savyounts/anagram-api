class WordsController < ApplicationController
  before_action :set_word, only: [:show, :update, :destroy]

  # GET /words
  def index
    @words = Word.all

    render json: @words
  end

  # GET /words/1
  def show
    render json: @word
  end

  # POST /words
  def create
    @word = Word.new(word_params)

    if @word.save
      @word.add_to_dictionary
      render json: @word, status: :created, location: @word
    else
      render json: @word.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /words/1
  def update
    if @word.update(word_params)
      render json: @word
    else
      render json: @word.errors, status: :unprocessable_entity
    end
  end

  #@word.anagrams 'undefined'
  def anagrams
    render json: @word.anagrams
  end

  # DELETE /words/1
  def destroy
    params[:letters] ? @word.destroy : Word.destroy_all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find_by(letters: params[:letters])
    end

    # Only allow a trusted parameter "white list" through.
    def word_params
      params.require(:word).permit(:letters)
    end
end

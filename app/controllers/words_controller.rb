class WordsController < ApplicationController
  before_action :verify_dictionary
  before_action :set_word, only: [:show, :update, :destroy, :anagrams]


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
    not_created = []
    JSON.parse.(strong_word_params[:words]).each do |word|
      # binding.pry
      @word = Word.new(letters: word)

      if @word.save
        @word.add_to_dictionary
        # render json: @word, status: :created, location: @word
      else
        not_created << @word.errors
      #   render json: @word.errors, status: :unprocessable_entity
      end
    end
    created = render :nothing => true, status: :created
    error = render not_created, status: :unprocessable_entity
    not_created ? error : created
  end

  # PATCH/PUT /words/1
  def update
    if @word.update(word_params)
      render json: @word
    else
      render json: @word.errors, status: :unprocessable_entity
    end
  end

  def anagrams
    #change to use serializer
    render json:  @word.find_anagrams(params[:limit])
  end

  # DELETE /words/1
  def destroy
    params[:letters] ? @word.destroy : Word.destroy_all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find_by(letters: params[:letters]) || Word.create(letters: params[:letters])
    end

    def strong_word_params
      params.require(:words)
    end

    # Only allow a trusted parameter "white list" through.
    def word_params
      params.require(:word).permit(:letters)
    end

    def verify_dictionary
      words = Word.all
      words.each{ |word| word.add_to_dictionary } if Word.dicitonary.empty?
    end
end

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
    created = []
    # binding.pry
    strong_word_params[:words].each do |word|
      @word = Word.new(letters: word)

      if @word.save
        @word.add_to_dictionary
        created << word
      else
        not_created << @word.errors
      end
    end
    not_created.empty? ? (render json: {created_words: created}, status: :created) :
     (render json: {not_created: not_created}, status: :unprocessable_entity)
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
    render json:  {anagrams: @word.find_anagrams(params[:limit])}
  end

  # DELETE /words/1
  def destroy

    params[:letters] ? @word.destroy : Word.destroy_all
  end

  def strong_word_params
    params.permit(words: [])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find_by(letters: params[:letters]) || Word.create(letters: params[:letters])
    end



    # Only allow a trusted parameter "white list" through.
    # def word_params
    #   params.require(:word).permit(:letters)
    # end

    def verify_dictionary
      words = Word.all
      words.each{ |word| word.add_to_dictionary } if Word.dicitonary.empty?
    end
end

class WordsController < ApplicationController
  before_action :set_word, only: [:show, :update, :anagrams, :delete_all]


  # GET /words
  def index
    render html: "Welcome to the Anagrams API! Check out the ReadMe to find out how to find your anagrams
  Try typing '/words/read' at the end of the URL."
  end

  # GET /words/:letters
  def show
    render json: @word
  end

  # POST /words
  def create
    not_created = []
    created = []
    strong_word_params[:words].each do |word|
      @word = Word.new(letters: word)

      if @word.save
        created << word
      else
        not_created << @word.errors
      end
    end
    not_created.empty? ? (render json: {created_words: created}, status: :created) :
     (render json: {not_created: not_created}, status: :unprocessable_entity)
  end

  # GET /anagrams/:letters
  def anagrams
    render json:  {anagrams: @word.find_anagrams(params[:limit])}
  end

# GET /dictionary_stats
  def dictionary_stats
    render json: Word.dictionary_stats
  end

  # DELETE /words/:letters or /words
  def destroy
    if params[:letters]
      set_word
      @word.destroy
    else
      Word.destroy_all
    end
  end

# DELETE /anagrams/:letters
  def delete_all
    Word.delete_all(@word)
  end




    # PATCH/PUT /words/:letters
    # def update
    #   if @word.update(word_params)
    #     render json: @word
    #   else
    #     render json: @word.errors, status: :unprocessable_entity
    #   end
    # end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find_by(letters: params[:letters]) || create_new_from_browser(params[:letters])
    end

    def strong_word_params
      params.permit(words: [])
    end

    def create_new_from_browser(word)
      return "Words can only contain letters" unless word.match(/\A[a-zA-Z]+\z/)
      Word.create(letters: word)
    end
end

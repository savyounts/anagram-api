class WordsController < ApplicationController
  before_action :verify_dictionary
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
        @word.add_to_dictionary
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
    render json: Word.dictionary_stats(Word.dictionary)
  end

  # DELETE /words/:letters or /words
  def destroy
    if params[:letters]
      set_word
      Word.dictionary[@word.dictionary_key] = Word.dictionary[@word.dictionary_key] - [@word.letters]
      @word.destroy
    else
      Word.dictionary.clear
      Word.destroy_all
    end
  end

# DELETE /anagrams/:letters
  def delete_all
    anagrams = @word.find_anagrams
    Word.dictionary[@word.dictionary_key].clear
    anagrams.each { |word| Word.find_by(letters: word).destroy }
    @word.destroy
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

    def verify_dictionary
      words = Word.all
      words.each{ |word| word.add_to_dictionary } if Word.dictionary.empty?
    end

    def create_new_from_browser(word)
      return "Words can only contain letters" unless word.match(/\A[a-zA-Z]+\z/)
      Word.create(letters: word)
    end
end

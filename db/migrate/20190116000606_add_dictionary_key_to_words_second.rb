class AddDictionaryKeyToWordsSecond < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :dictionary_key, :string
  end
end

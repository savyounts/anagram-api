class AddDictionaryIdToWord < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :dictionary_id, :integer
  end
end

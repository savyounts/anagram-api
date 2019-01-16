class RemoveAnagramsFromWords < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :anagrams, :array
  end
end

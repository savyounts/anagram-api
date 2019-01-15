class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :letters
      t.string :anagrams, default: [], array: true
      t.timestamps
    end
  end
end

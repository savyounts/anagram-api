class RemoveSortedFromWords < ActiveRecord::Migration[5.2]
  def change
    remove_column :words, :sorted, :string

  end
end

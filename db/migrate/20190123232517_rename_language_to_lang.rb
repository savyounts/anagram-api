class RenameLanguageToLang < ActiveRecord::Migration[5.2]
  def change
    rename_column :dictionaries, :language, :lang
  end
end

class ChangeCocktailsIntructionsToText < ActiveRecord::Migration[5.0]
  def change
    change_column :cocktails, :instructions, :text
  end
end

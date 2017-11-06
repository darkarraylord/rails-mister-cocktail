class AddDifficultyToCocktails < ActiveRecord::Migration[5.0]
  def change
    add_column :cocktails, :difficulty, :integer
  end
end

require 'open-uri'
require 'json'
require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#### Seeded ingredients
# result = JSON.parse(open("http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list").read)

# result["drinks"].each do |ingredient|
#    Ingredient.create(name: ingredient["strIngredient1"])
# end
## Seed Cocktails

50.times do
 cocktail = JSON.parse(open("http://www.thecocktaildb.com/api/json/v1/1/random.php").read)["drinks"]
 new_cocktail = Cocktail.new(
  name: cocktail[0]["strDrink"],
  category: cocktail[0]["strCategory"],
  alcoholic: cocktail[0]["strAlcoholic"],
  glass: cocktail[0]["strGlass"],
  instructions: cocktail[0]["strInstructions"],
  difficulty: cocktail[0]["strDrink"],
  )
 photo = cocktail[0]['strDrinkThumb']
 new_cocktail.send(:photo_urls=, [photo], folder: Rails.env.to_s, use_filename: true, image_metadata: true)

 for i in 1..15
  if !cocktail[0]["strIngredient#{i}"].blank?
    ingredient = Ingredient.where(name: cocktail[0]["strIngredient#{i}"])[0]
    if ingredient.nil?
      new_ingredient = Ingredient.create(name: cocktail[0]["strIngredient#{i}"])
      new_cocktail.doses.new(description: cocktail[0]["strMeasure#{i}"], ingredient: new_ingredient)
    else
      new_cocktail.doses.new(description: cocktail[0]["strMeasure#{i}"], ingredient: ingredient)
    end
  end
 end
 new_cocktail.save
end

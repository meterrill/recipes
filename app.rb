require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get ("/") do
    @recipes = Recipe.all()
  erb(:index)
end

post ("/new_recipe") do
  name = params.fetch("recipe_name")
  @recipe_name = Recipe.create({:name => params.fetch("recipe_name")})
  @recipes = Recipe.all()
  erb(:index)
end

get ("/recipe/:id") do
  @recipe = Recipe.find(params.fetch("id").to_i())
  @ingredients = Ingredient.all()
  erb(:recipe)
end

patch("/recipe/:id") do
  name = params.fetch("update_recipe_name")
  @recipe = Recipe.find(params.fetch("id").to_i())
  @recipe.update({:name => name})
  @recipes = Recipe.all()
  @ingredients = Ingredient.all()
  erb(:recipe)
end

delete("/recipe/:id") do
  @recipe = Recipe.find(params.fetch("id").to_i())
  @recipe.delete()
  @recipes = Recipe.all()
  @ingredients = Ingredient.all()
  erb(:index)
end

post("/recipe/:id") do
  ingredient = params.fetch("specific_ingredient")
  amount = params.fetch("amount")
  id = params.fetch("id")
  ingredient = Ingredient.create({:name => ingredient, :amount => amount, :recipe_id => id})
  @recipe = Recipe.find(params.fetch("id").to_i())
  @ingredients = Ingredient.all()
  erb(:recipe)
end

post("/recipe/:id/instructions") do
  instructions = params.fetch("instructions")
  @recipe = Recipe.find(params.fetch("id").to_i())
  @recipe.update({:instructions => instructions})
  @recipes = Recipe.all()
  erb(:recipe)
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index 

  end

  def search
  	search_results = Yummly.search(params[:search])
    my_recipes = search_results.matches.map do |recipe|
    	url = recipe["id"]
    	full_url = "http://www.yummly.com/recipe/" + url
    	doc = Nokogiri::HTML(HTTParty.get(full_url))
      one_recipe = {}
      one_recipe[:name] = recipe["recipeName"]
      third_party = doc.css("button#source-full-directions")[0]["link"]
        if third_party.include?("http://")
          one_recipe[:url] = (third_party[5..-1])
        else
          one_recipe[:url] = ('//www.yummly.com' + third_party)
        end
      ingredient_array = []
      i = 1
      counter = doc.css('ul li.ingredient').length
      while i <= counter do
          ingredient_hash = {
              :amount => doc.css("li.ingredient:nth-child(#{i}) span.amount").text, 
              :ingredient => doc.css("li.ingredient:nth-child(#{i}) strong.name").text,
              :instructions => doc.css("li.ingredient:nth-child(#{i}) span.remainder").text
            }
          ingredient_array.push(ingredient_hash)
        i += 1
      end
      one_recipe[:ingredients] = ingredient_array
      many_recipes = []
      many_recipes.push(one_recipe)
      {:recipe => many_recipes}
    end
  	render json: {:recipes => my_recipes}.to_json
  end

end

# recipes = [
#  {
#     name: 'jahsdf'
#     url: 'jhaksdjf'
#     ingredients: 
#       [
#         {
#           amount:
#           instructions:
#           name:
#         }
#        ]
#     
#   },
#   {
#     name: 'jahsdf'
#     url: 'jhaksdjf'
#     ingredients: 
#       [
#         {
#           amount:
#           instructions:
#           name:
#         }
#        ]
#     
#   },
#   
# ]

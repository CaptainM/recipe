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
    	one_recipe = []
      recipe_name = recipe["recipeName"]
      one_recipe.push(recipe_name)

      third_party = doc.css("button#source-full-directions")[0]["link"]
      puts third_party
      third_party_doc = Nokogiri::HTML(HTTParty.get(third_party))
      one_recipe.push(third_party_doc)

      i = 1
      counter = doc.css('ul li.ingredient').length
      while i <= counter do 
        one_recipe.push(
          {
            :amount => doc.css("li.ingredient:nth-child(#{i}) span.amount").text, 
            :ingredient => doc.css("li.ingredient:nth-child(#{i}) strong.name").text,
            :instructions => doc.css("li.ingredient:nth-child(#{i}) span.remainder").text
          }
        )
        i += 1
      end
      {:recipe => one_recipe}
    end
  	render json: {:recipes => my_recipes}.to_json
    

  end
end

# recipes = [
#   [
#     {
#       amount: 'jahsdf'
#     },
#     {
#       amount: 'jhaksdjf'
#     }
#   ],

#   [
#     {
#       amount: 'oqiweru'
#     }
#   ]
# ]
